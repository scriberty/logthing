require 'test_helper'

describe Logthing::Message do
  let(:sender)  { "ben@example.com"           }
  let(:time)    { "2013-06-03T19:03:19-08:00" }
  let(:als)     { "Ben Bleything"             }
  let(:content) { "message content!"          }

  let(:xml)   { %Q[<message sender="#{sender}" time="#{time}" alias="#{als}">#{content}</message>] }
  let(:nodes) { Nokogiri::XML(xml).root }

  # turns out `message` gets used somewhere inside minitest and so we have to
  # abbreviate here.
  let(:msg) { Logthing::Message.from_xml(nodes) }

  it "exposes the sending account" do
    assert_equal sender, msg.sender
  end

  it "exposes the message timestamp" do
    assert_equal time, msg.time
  end

  it "exposes the sender's alias" do
    assert_equal als, msg.alias
  end

  it "exposes the message content" do
    assert_equal content, msg.content
  end
end
