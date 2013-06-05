class Logthing::Chat
  attr_accessor :account, :service, :events, :messages

  def self.from_xml(xml)
    xml = Nokogiri::XML(xml).root

    self.new.tap do |chat|
      chat.account = xml['account']
      chat.service = xml['service']

      chat.events = xml.xpath("//xmlns:event | //xmlns:status").map do |evt|
        Logthing::Event.from_xml evt
      end

      chat.messages = xml.xpath("//xmlns:message").map do |msg|
        Logthing::Message.from_xml msg
      end
    end
  end
end
