# -*- encoding : utf-8 -*-

require_relative '../models/element'
require_relative '../config/initializers/elements'
require_relative '../models/algorithm'
require_relative '../models/color_scheme/base_color_scheme'
require_relative '../models/renderer'
require_relative '../services/breaking_service'

describe BreakingService do
  subject { described_class.new }

  describe '#make_me_bad' do

    it 'should draw both name and surname' do
      BreakingService.new('Fabiano', 'Beselga').make_me_bad
    end

    it 'should draw a single name' do
      BreakingService.new('Kadu').make_me_bad
    end

    it 'should throw exception' do
      expect { BreakingService.new('Ada').make_me_bad }.to raise_error(Exception)
    end

    it 'should draw only surname' do
      BreakingService.new('Ada', 'Strong').make_me_bad
    end

    it 'should draw composite names' do
      BreakingService.new('José Pedro', 'da Silva').make_me_bad
    end

  end
end
