require 'nokogiri'

module Logthing
  VERSION = "0.0.1"
end

$: << "lib"
require 'logthing/chat'
require 'logthing/event'
require 'logthing/message'
