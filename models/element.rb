class Element < Struct.new(:atomic_number, :name, :symbol)
  def self.single_char
    Elements.reject{|element| element.symbol.size > 1}
  end
  def self.double_char
    Elements.reject{|element| element.symbol.size != 2}
  end
  def self.find_by_symbol(symbol)
    Elements.select {|element| element.symbol == symbol}.first
  end
end
