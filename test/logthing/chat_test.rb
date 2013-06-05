require 'test_helper'

describe Logthing::Chat do
  let(:xml) {
    <<-EOXML
    <?xml version="1.0" encoding="UTF-8" ?>
    <chat xmlns="http://purl.org/net/ulf/ns/0.4-02" account="#{account}" service="#{service}" adiumversion="1.5.4" buildid="5efcd11df694">
    <event type="windowOpened" sender="#{account}" time="2013-06-03T18:56:34-08:00"></event>
    <message sender="#{account}" time="2013-06-03T19:03:19-08:00" alias="Ben Bleything">message content!</message>
    <message sender="#{sender}" time="2013-06-03T19:12:31-08:00" alias="Other Party">oh hi</message>
    <event type="windowClosed" sender="#{sender}" time="2013-06-03T19:14:49-08:00"></event> 
    <status type="offline" sender="#{sender}" time="2013-06-03T19:14:50-08:00" alias="Other Party"></status>
    <event type="windowClosed" sender="#{account}" time="2013-06-03T19:15:07-08:00"></event>
    </chat>
    EOXML
  }

  let(:chat) { Logthing::Chat.from_xml(xml) }

  it "exposes the account" do
    assert_equal account, chat.account
  end

  it "exposes the chat service" do
    assert_equal service, chat.service
  end

  it "exposes the chat's events" do
    assert_equal 4, chat.events.count
    assert chat.events.map(&:class).all? {|k| k == Logthing::Event }
  end

  it "converts statuses to events" do
    assert chat.events.any? {|e| e.event == 'offline' }
  end

  it "exposes the chat's messages" do
    assert_equal 2, chat.messages.count
    assert chat.messages.map(&:class).all? {|k| k == Logthing::Message }
  end
end
