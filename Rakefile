require 'bundler/setup'
require 'oj'
require 'tire'

### use curb instead of RestClient because ugh :'(
require 'curb'
require 'tire/http/clients/curb'
Tire.configure do
  client Tire::HTTP::Client::Curb
end

### set up the environment
ENV['ELASTICSEARCH_URL'] ||= ENV['BOXEN_ELASTICSEARCH_URL']
LOG_ROOT = "#{ENV['HOME']}/Library/Application Support/Adium 2.0/Users/Default/Logs"

### Get rid of the tire tasks
Rake::Task.clear

### load tasks from tasks/*.rake
Dir['tasks/*.rake'].each do |rakefile|
  load rakefile
end

### `rake` should run the check tasks
task :default => :check

desc "Runs pre-flight checks"
task :check => ["check:es", "check:adium"]

namespace :check do
  $stdout.sync = true

  task :es do
    print "Checking ElasticSearch... "

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

    if File.directory? LOG_ROOT
      puts "OK!"
    else
      puts "not found :("
      puts " * Are your logs stored in #{LOG_ROOT} ?"
      exit 1
    end
  end
end
