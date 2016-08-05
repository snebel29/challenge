class Array
  def my_flatten(memo=[])
    self.each {|element| element.kind_of?(Array) ? element.my_flatten(memo) : memo << element }
    memo
  end
end
