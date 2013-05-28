require 'find'
require 'nokogiri'
require 'ruby-progressbar'

### Helpers!
module Enumerable
  def each_with_progress(title, subject, &block)
    pbar = ProgressBar.create(
      :title  => title,
      :total  => self.count,
      :format => "%t %C #{subject}... (%p%%) |%B| %e"
    )

    self.each do |item|
      block.call(item)
      pbar.increment
    end
  end
end

desc "Import Adium logs"
task :import => ["import:adium"]

def extract(evt, out)
  out[:sender] = evt['sender']
  out[:alias]  = evt['alias']
  out[:text]   = evt.text
  out[:ts]     = evt['time']

  return out
end

namespace :import do
  task :adium => :check do
    puts "Finding files..."
    files = []
    Find.find(LOG_ROOT) do |path|
      files << path if path =~ /xml$/
    end

    Tire.index "logthing" do
      puts "Clearing and recreating index '#{name}'..."
      delete and create

      files.each_with_progress("Importing", "log files") do |path|
        components = path.sub(/^#{LOG_ROOT}/, '').split('/').reject(&:blank?)
        medium, account = components.first.split('.', 2)

        xml = Nokogiri::XML(File.read path)

        metadata = {
          medium: medium,
          accounts: {
            local: account,
            remote: components[1]
          }
        }

        entries = []
        alias_map = {}

        ### do one pass to grab the aliases
        xml.xpath('//xmlns:message').each {|m| alias_map[m['sender']] ||= m['alias'] }

        ### pull all messages
        xml.xpath('//xmlns:message').each do |msg|
          doc = extract(msg, metadata.dup)

          if msg['sender'] == doc[:accounts][:local]
            doc[:from] = {
              name: alias_map[doc[:accounts][:local]],
              account: doc[:accounts][:local]
            }

            doc[:to] = {
              name: alias_map[doc[:accounts][:remote]],
              account: doc[:accounts][:remote]
            }

          elsif msg['sender'] == doc[:accounts][:remote]
            doc[:from] = {
              name: alias_map[doc[:accounts][:remote]],
              account: doc[:accounts][:remote]
            }

            doc[:to] = {
              name: alias_map[doc[:accounts][:local]],
              account: doc[:accounts][:local]
            }

          else
            doc[:from] = { name: :unknown, account: :unknown }
            doc[:to]   = { name: :unknown, account: :unknown }
          end

          doc[:type] = :message
          doc[:text] = msg.text

          entries << doc
        end

        ### events like going online/offline, starting/finish encryption, file
        ### transfers, away messages, etc
        xml.xpath('//xmlns:status | //xmlns:event').each do |evt|
          entry = extract(evt, metadata.dup)

          entry[:type]  = :event
          entry[:event] = evt['type']

          entries << entry
        end

        import entries.map {|h| h.delete_if {|k,v| v.nil? }}
      end
    end
  end
end
