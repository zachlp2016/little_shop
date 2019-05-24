class Cart
  attr_reader :contents

  def initialize(session)
    @contents = session || Hash.new(0)
  end

  def add(item_id)
    @contents[item_id.to_s] ||= 0
    @contents[item_id.to_s] += 1
  end
end
