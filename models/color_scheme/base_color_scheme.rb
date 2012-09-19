module ColorScheme

  class BaseColorScheme
    class << self
      attr_accessor :main_text_font, :main_text_color, :square_fill, :square_line, :square_line_thickness
    end
    @square_line_thickness = 2
  end

  class Development < BaseColorScheme
    @main_text_font = 'vendor/fonts/CooperMdBTMedium.ttf'
    @main_text_color = 'green'
    @square_fill = 'green'
    @square_line = 'white'
  end

  class Classic < BaseColorScheme
    @main_text_font = 'vendor/fonts/CooperMdBTMedium.ttf'
    @main_text_color = 'white'
    @square_fill = '#006a25'
    @square_line = 'white'
  end
  
  class FanMade < BaseColorScheme
    @main_text_font = 'vendor/fonts/CooperMdBTMedium.ttf'
    @main_text_color = '#006a25'
    @square_fill = '#006a25'
    @square_line = 'black'
    @square_line_thickness = 1
  end

end