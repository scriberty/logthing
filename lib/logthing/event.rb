class Logthing::Event
  attr_accessor :event, :sender, :time

  def self.from_xml(xml)
    xml = Nokogiri::XML(xml).root if xml.is_a? String

    self.new.tap do |evt|
      evt.event   = xml['type']
      evt.sender  = xml['sender']
      evt.time    = xml['time']
    end
  end

  def ==(other)
    other.event  == event  &&
    other.sender == sender &&
    other.time   == time
  end

  # tire import API
  def to_indexed_json
    {
      :event  => event,
      :sender => sender,
      :time   => time
    }.to_json
  end
end
