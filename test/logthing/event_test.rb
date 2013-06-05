require 'test_helper'

describe Logthing::Event do
  let(:sender)  { "ben@example.com"           }
  let(:time)    { "2013-06-03T19:03:19-08:00" }
  let(:type)    { "windowOpened"              }

  let(:xml)   { %Q[<event type="#{type}" sender="#{sender}" time="#{time}"></event>] }
  let(:nodes) { Nokogiri::XML(xml).root }
  let(:event) { Logthing::Event.from_xml(nodes) }

  it "exposes the event type" do
    assert_equal type, event.type
  end

  it "exposes the event sender" do
    assert_equal sender, event.sender
  end

  it "exposes the event timestamp" do
    assert_equal time, event.time
  end
end
