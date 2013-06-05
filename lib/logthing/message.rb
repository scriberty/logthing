class Logthing::Message
  attr_accessor :sender, :time, :alias, :content

  def self.from_xml(xml)
    self.new.tap do |msg|
      msg.sender  = xml['sender']
      msg.time    = xml['time']
      msg.alias   = xml['alias']
      msg.content = xml.text
    end
  end
end
