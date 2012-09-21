require 'rvg/rvg'
Magick::RVG::dpi = 72

class Renderer
  attr_accessor :element, :square_x, :square_y, :square_size, :sufix, :prefix
  SQUARE_TEXT_COLOR = 'white'  
  DESTINATION_PATH = (ENV['RACK_ENV']=='production' ? "#{settings.root}/tmp" : "tmp")
  BACKGROUND_PATH = 'public/images/backgrounds/'
  def initialize(params={})
    params.each{|k,v| instance_variable_set("@#{k}", v) }
    @color_scheme ||= color_scheme=ColorScheme::Classic
  end

  def self.draw(name, params={})
    wallpaper = params[:background] || 'bb_wallpaper.jpeg'
    rvg = Magick::RVG.new(10.in, 6.in) {|canvas| yield canvas }
    name_img = rvg.draw
    base = Magick::Image.read(BACKGROUND_PATH + wallpaper).first
    #formato do cover do facebook (com crop no meio)
    base = base.resize_to_fill(851, 315, Magick::CenterGravity)
    combined = base.composite(name_img, Magick::CenterGravity, 70, 80, Magick::OverCompositeOp) #the 0,0 is the x,y
    combined.format = 'jpeg'
    combined.write("#{DESTINATION_PATH}/#{name}.jpg")
  end

  def draw(canvas)
    @square_size ||= 100
    @square_y ||= 10
    @square_x ||= 10
    @start = @square_x
    text_y = -28
    font_size = relative_font_size(60)
    @square_x += (0.50 * (1 + @prefix.size) * font_size) if @prefix.size > 0

    if @element

    canvas.rect(@square_size, @square_size, @square_x, @square_y).styles(:stroke_width => @color_scheme.square_line_thickness, :stroke => @color_scheme.square_line, :fill=> @color_scheme.square_fill)

      canvas.text(*square_offset(-49, text_y)) do |title|
        title.tspan(@element.symbol).styles(:text_anchor=>'middle', :font_size=> font_size,
                     :font_family=>'Helvetica',  :font_weight => 'bold', :fill=> SQUARE_TEXT_COLOR)
      end

      canvas.text(*square_offset(-5, -80)) do |title|
       title.tspan(@element.atomic_number.to_s).styles(:text_anchor=>'end', :font_size => relative_font_size(20),
                    :font_family=>'Times', :fill => SQUARE_TEXT_COLOR)
      end
    end
    style_for_text = {:font_size => font_size,
          :font => @color_scheme.main_text_font, :fill => @color_scheme.main_text_color}

    canvas.text(@start, square_offset(-190, text_y)[1]) do |title|
      title.tspan(@prefix).styles(style_for_text)
    end unless @prefix.empty?

    canvas.text(*square_offset(12, text_y)) do |title|
      title.tspan(@sufix).styles(style_for_text)
    end unless !@sufix || @sufix.empty?

  end
  
  protected 
  def square_offset(offset_x, offset_y)
    [@square_x + @square_size + (offset_x/100.0)*@square_size, @square_y + @square_size + (offset_y/100.0)*@square_size]
  end
  
  def relative_font_size(size)
    (size/100.0)*@square_size
  end

end
