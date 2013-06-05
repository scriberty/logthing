require 'test_helper'

describe Logthing::Message do
  let(:sender)  { "ben@example.com"           }
  let(:time)    { "2013-06-03T19:03:19-08:00" }
  let(:als)     { "Ben Bleything"             }
  let(:content) { "message content!"          }

  let(:xml)   { %Q[<message sender="#{sender}" time="#{time}" alias="#{als}">#{content}</message>] }

  # turns out `message` gets used somewhere inside minitest and so we have to
  # abbreviate here.
  let(:msg) { Logthing::Message.from_xml(xml) }

  describe '.to_xml' do
    it 'accepts a string or a Nokogiri object' do
      nodes = Nokogiri::XML(xml).root

      from_xml = Logthing::Message.from_xml(xml)
      from_nkg = Logthing::Message.from_xml(nodes)

      assert_equal from_xml, from_nkg
    end
  end

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

  describe 'tire compatibility' do
    it 'has a #_type method that returns "message"' do
      assert_equal 'message', msg._type
    end

    it 'has a #to_indexed_json method that returns the object' do
      obj = JSON.parse(msg.to_indexed_json)

      assert_equal sender,  obj['sender']
      assert_equal time,    obj['time']
      assert_equal als,     obj['alias']
      assert_equal content, obj['content']
    end
  end
end
