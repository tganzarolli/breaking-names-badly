module Spice
  @@menu = {:mexican => {:male => 'tio', :female => 'la'}, :asian => {:male => 'san', :female => 'chan'}, :american => {:female => 'the', :male => 'the'}, :german => {:male => 'herr', :female => 'frau'}}
  def menu
    @@menu
  end
  module_function :menu
end