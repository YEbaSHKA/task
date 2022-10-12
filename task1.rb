# frozen_string_literal: true

# all? any? include? none? each map! map size count length select find find_all find_index reject max min
# each map! map size count length select find find_all find_index max min

require_relative './my_enumerable'

array1 = [10, 0.25, 47, 8, -64, -147]
array2 = %w(rubya russia apple kotlina belorusian)
begin
  p array1.each
#   p array2.my_none?(/z/)
#   p array2.my_any?{|v| v.length >11}
#   p array2.my_include?('rubya')
#   p array2.my_all?(/a/)
#   p array2.my_reject{|n| !n.include?('ru')}
#   p array1.my_inject(1000) { |sum, n| sum - n }
rescue LocalJumpError => e
  p e.message
rescue TypeError => e
  p e.message
rescue ArgumentError => e
  p e.message
rescue NoMethodError => e
  p e.message
end
