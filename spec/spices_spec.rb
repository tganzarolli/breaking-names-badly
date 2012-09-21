require_relative '../models/element'
require_relative '../config/initializers/elements'
require_relative '../config/initializers/spices'
require_relative '../models/algorithm'

describe Spice do

  describe '#test_spice' do

    context 'all spices should add a flavor' do
      algo = Algorithm.new
      it do 
        Spice::menu.each {|kind, genders| genders.each_value {|spice| algo.scan(spice).should_not be_nil } }
      end
    end

  end
end
