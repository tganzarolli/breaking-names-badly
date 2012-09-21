require_relative '../models/color_scheme/base_color_scheme'
class BreakingService
  def initialize(name, surname=nil, params={})
    @@algorithm ||= Algorithm.new
    @name = name
    @surname = surname
    @params = params
  end
  
  def make_me_bad
    bad_name = @@algorithm.scan(@name)
    bad_surname = (@surname && @@algorithm.scan(@surname)) || nil
    raise Exception.new('Unbreakable! Join the DEA') unless bad_name || bad_surname
    Renderer.draw(@name, @params) do |canvas| 
      Renderer.new(split_words(bad_name, @name).merge(:element => bad_name.element)).draw(canvas)
      Renderer.new(split_words(bad_surname, @surname).merge(:element => bad_surname.element, :square_x => 106, :square_y => 160)).draw(canvas) if bad_surname
    end
  end
  
  protected
  
  def split_words(bad, name)
    if !bad
      {:prefix => name}
    else
      {:prefix => name[0...bad.position], :sufix => name[bad.position + bad.element.symbol.size...name.length]}
    end
  end

end