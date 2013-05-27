require 'bundler/setup'
require 'oj'
require 'tire'

### Get rid of the tire tasks
Rake::Task.clear

### `rake` should run the check tasks
task :default => :check

desc "Runs pre-flight checks"
task :check => ["check:es", "check:adium"]

namespace :check do
  $stdout.sync = true

  task :es do
    print "Checking ElasticSearch... "
    ENV["ELASTICSEARCH_URL"] ||= ENV["BOXEN_ELASTICSEARCH_URL"]

    begin
      Tire.index "logthing" do
        create
      end
    rescue => ex
      puts "failed :("
      puts "  * could not connect to ElasticSearch. Check that it's running on http://localhost:9200 or that ELASTICSEARCH_URL is set."
      exit 1
    else
      puts "OK!"
    end
  end

  task :adium do
    print "Checking for Adium logs... "
    dir = ENV['HOME'] + "/Library/Application Support/Adium 2.0/Users/Default/Logs"

    if File.directory? dir
      puts "OK!"
    else
      puts "not found :("
      puts " * Are your logs stored in #{dir} ?"
      exit 1
    end
  end
end
