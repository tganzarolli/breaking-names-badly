require_relative 'element'
require_relative '../config/initializers/elements'

Bad = Struct.new(:position, :element)
class Algorithm

  def scan(name)
    result = scan_case(name, 'double')
    if !result || (result && result.position > 0)
      single_result = scan_case(name, 'single')
      result = single_result if !result || (single_result && single_result.position < result.position)
    end
    result
  end

  protected
  def scan_case(name, cardinality)
    min_pos = 999999
    found_element = nil
    Element.send("#{cardinality}_char").each do |element|
      pos = name.downcase =~ /#{element.symbol.downcase}/
      if pos && pos < min_pos
        min_pos = pos
        found_element = element
      end
      break if min_pos == 0
    end
    if found_element
      Bad.new(min_pos, found_element)
    end
  end

end
