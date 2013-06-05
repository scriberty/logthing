class Logthing::Event
  attr_accessor :event, :sender, :time, :content

  def self.from_xml(xml)
    xml = Nokogiri::XML(xml).root if xml.is_a? String

    self.new.tap do |evt|
      evt.event   = xml['type']
      evt.sender  = xml['sender']
      evt.time    = xml['time']
      evt.content = xml.text
    end
  end

  def ==(other)
    other.event   == event  &&
    other.sender  == sender &&
    other.time    == time   &&
    other.content == content
  end

  ### tire API
  def _type ; 'event' ; end

  def to_indexed_json
    {
      :event   => event,
      :sender  => sender,
      :time    => time,
      :content => content
    }.to_json
  end
end
