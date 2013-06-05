require 'minitest/autorun'
require 'minitest/pride'

require 'logthing'

class Minitest::Spec
  let(:service) { "Jabber"                    }
  let(:sender)  { "other@example.com"         }
  let(:account) { "ben@example.com"           }
  let(:time)    { "2013-06-03T19:03:19-08:00" }
  let(:content) { "This is a message #yolo"   }
end
