require 'test_helper'

describe Logthing::Event do
  let(:sender)  { "ben@example.com"           }
  let(:time)    { "2013-06-03T19:03:19-08:00" }
  let(:type)    { "fileTransferCompleted"     }
  let(:content) { "Successfully sent cat.png" }

  let(:xml)   { %Q[<event type="#{type}" sender="#{sender}" time="#{time}">#{content}</event>] }
  let(:event) { Logthing::Event.from_xml(xml) }

  describe '.to_xml' do
    it 'accepts a string or a Nokogiri object' do
      nodes = Nokogiri::XML(xml).root

      from_xml = Logthing::Event.from_xml(xml)
      from_nkg = Logthing::Event.from_xml(nodes)

      assert_equal from_xml, from_nkg
    end
  end

  it "exposes the event type as 'event'" do
    assert_equal type, event.event
  end

  it "exposes the event sender" do
    assert_equal sender, event.sender
  end

  it "exposes the event timestamp" do
    assert_equal time, event.time
  end

  it "exposes the event content" do
    assert_equal content, event.content
  end

  describe 'tire compatibility' do
    it 'has a #_type method that returns "event"' do
      assert_equal 'event', event._type
    end

    it 'has a #to_indexed_json method that returns the object' do
      obj = JSON.parse(event.to_indexed_json)

      assert_equal type,    obj['event']
      assert_equal sender,  obj['sender']
      assert_equal time,    obj['time']
      assert_equal content, obj['content']
    end
  end
end
