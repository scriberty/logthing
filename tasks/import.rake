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

        metadata = {
          medium: medium,
          account: account,
          them: components[1]
        }

        entries = []
        Nokogiri::XML(File.read path).xpath('//xmlns:message').each do |msg|
          entry = metadata.dup
          entry[:sender] = msg['sender']
          entry[:sender_name] = msg['alias']
          entry[:text] = msg.text
          entry[:ts] = msg['time']

          entries << entry
        end

        import entries
      end
    end
  end
end
