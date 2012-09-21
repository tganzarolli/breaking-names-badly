module Spice
  @@menu = {:mexican => {:male => 'tio', :female => 'la'}, :japanese => {:male => 'san', :female => 'chan'}, :american => {:female => 'the', :male => 'the'}, :german => {:male => 'herr', :female => 'fraulein'}}
  def menu
    @@menu
  end
  module_function :menu
end