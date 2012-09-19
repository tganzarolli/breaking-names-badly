require_relative '../models/element'
require_relative '../config/initializers/elements'
require_relative '../models/color_scheme/base_color_scheme'
require_relative '../models/renderer'

describe Renderer do
  it 'should draw a square' do
    name = 'Gabi'
    Renderer.draw(name) { |canvas| Renderer.new(:element => Element.find_by_symbol('Ga'), :prefix => '', :sufix => 'bi').draw(canvas) }
  system("open tmp/#{name}_final.jpg") if ENV['OPEN_IMAGE']
  end
  it 'should draw another square' do
    name = 'Kakarotto'
    Renderer.draw(name) { |canvas| Renderer.new(:element => Element.find_by_symbol('O'), :prefix => 'Kakar', :sufix => 'to', :color_scheme => ColorScheme::Development).draw(canvas) }
    system("open tmp/#{name}_final.jpg") if ENV['OPEN_IMAGE']
  end
  it 'should draw yet another square' do
    name = 'Thiago'
    Renderer.draw(name, wallpaper='dark_knight.jpg') do |canvas| 
      Renderer.new(:element => Element.find_by_symbol('I'), :prefix => 'Th', :sufix => 'ago', :color_scheme => ColorScheme::FanMade).draw(canvas)
      Renderer.new(:element => Element.find_by_symbol('Ga'), :prefix => '', :sufix => 'nzarolli', :square_x => 106, :square_y => 160, :color_scheme => ColorScheme::FanMade).draw(canvas)
    end
    system("open tmp/#{name}_final.jpg") if ENV['OPEN_IMAGE']
  end
  it 'should draw 2 squares' do
    name = 'Thiago2'
    Renderer.draw(name) do |canvas| 
      Renderer.new(:element => Element.find_by_symbol('Th'), :prefix => '', :sufix => 'iago').draw(canvas)
      Renderer.new(:element => Element.find_by_symbol('Ga'), :prefix => '', :sufix => 'nzarolli', :square_x => 106, :square_y => 160).draw(canvas)
    end
    system("open tmp/#{name}_final.jpg") if ENV['OPEN_IMAGE']
  end
end
