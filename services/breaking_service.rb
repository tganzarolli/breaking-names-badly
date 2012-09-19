require_relative '../models/color_scheme/base_color_scheme'
class BreakingService
  def initialize(name)
    @name = name
    @algorithm = Algorithm.new
  end
  
  def make_me_bad
    bad = @algorithm.scan(@name)
    raise Exception.new('Unbreakable! Join the DEA') unless bad
    Renderer.draw(@name) { |canvas| Renderer.new(split_words(bad).merge(:element => bad.element)).draw(canvas) }
  end
  
  protected
  
  def split_words(bad)
    {:prefix => @name[0...bad.position], :sufix => @name[bad.position + bad.element.symbol.size...@name.length]}
  end

end
