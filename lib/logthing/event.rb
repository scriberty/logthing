class Logthing::Event
  attr_accessor :type, :sender, :time

  def self.from_xml(xml)
    self.new.tap do |evt|
      evt.type    = xml['type']
      evt.sender  = xml['sender']
      evt.time    = xml['time']
    end
  end
end
