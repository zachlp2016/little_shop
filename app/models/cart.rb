class Cart
  attr_accessor :contents

  def initialize(session)
    @contents = session
  end

  def self.clear
     ObjectSpace.each_object(self).each do |cart|
       cart.contents = {}
     end
  end

end
