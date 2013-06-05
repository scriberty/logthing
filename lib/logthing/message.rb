class Logthing::Message
  attr_accessor :sender, :time, :alias, :content

  def self.from_xml(xml)
    xml = Nokogiri::XML(xml).root if xml.is_a? String

    self.new.tap do |msg|
      msg.sender  = xml['sender']
      msg.time    = xml['time']
      msg.alias   = xml['alias']
      msg.content = xml.text
    end
  end

  def ==(other)
    other.sender  == sender  &&
    other.time    == time    &&
    other.content == content &&
    other.alias   == self.alias
  end
end
