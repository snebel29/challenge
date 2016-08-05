class Array
  def my_flatten(memo=[])
    self.each {|e| e.kind_of?(Array) ? e.my_flatten(memo) : memo << e }
    memo
  end
end
