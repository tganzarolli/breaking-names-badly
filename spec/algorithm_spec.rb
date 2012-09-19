require_relative '../models/element'
require_relative '../config/initializers/elements'
require_relative '../models/algorithm'

describe Algorithm do
  subject { described_class.new }

  describe '#scan' do

    context 'symbols with single char' do
      it { subject.scan('Fabiano').should == Bad.new(0, Element.find_by_symbol('F')) }
    end

    context 'symbols with two chars' do
      it { subject.scan('Thiago').should == Bad.new(0, Element.find_by_symbol('Th')) }
    end

    context 'symbols with one char not in first position' do
      it { subject.scan('Marilisa').should == Bad.new(1, Element.find_by_symbol('Ar')) }
    end

  end
end
