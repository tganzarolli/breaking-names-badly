require_relative '../models/color_scheme/base_color_scheme'
require_relative '../config/initializers/spices'
require_relative '../models/algorithm'
require_relative '../models/renderer'

class BreakingService

  def initialize(name, surname=nil, params={})
    @@algorithm ||= Algorithm.new
    @name = name
    @surname = surname
    @params = params
  end

  def spice_it_up(flavor, gender)
    @name = "#{Spice::menu[flavor][gender || :male]} #{@name}"
    self
  end

  def make_me_bad
    bad_name = @@algorithm.scan(@name)
    bad_surname = (@surname && @@algorithm.scan(@surname)) || nil
    raise Exception.new('Unbreakable! Join the DEA') unless bad_name || bad_surname
    Renderer.draw(file_name, @params) do |canvas|
      name_opts = split_words(bad_name, @name).merge(:element => bad_name && bad_name.element || nil)
      name_opts[:color_scheme] = @params[:color_scheme]
      Renderer.new(name_opts).draw(canvas)
      if bad_surname
        surname_opts = split_words(bad_surname, @surname).merge(:element => bad_surname.element, :square_x => 106, :square_y => 160)
        surname_opts[:color_scheme] = @params[:color_scheme]
        Renderer.new(surname_opts).draw(canvas)
      end
    end
  end
  
  def file_name
    @file_name ||= "#{Time.now.usec}#{@params[:facebook_id]}"
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
