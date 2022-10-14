# frozen_string_literal: true

# all? any? include? none? each map! map size count length select find find_all find_index reject max min
# No completed: max+- min+-

require_relative './my_enumerable'

array1 = [10, 47, 8, -64, 147, 35]
array2 = %w(rubya russia apple kotlina belorusian)
array3 = []
begin
  p array1.min(0){ |a, b| a.size <=> b.size }
  p array1.my_min(0){ |a, b| a.size <=> b.size }
#   p array1.my_max(2){ |a, b| a.size <=> b.size }
#   p array1.sort_by(&:size)
#   p array1.my_find_index{ |i| i % 8 == 0}
#   p array1.my_find_all{|n| n % 5 == 0}
#   p array1.my_find{|n| n % 5 == 0}
#   p [nil].my_size
#   p array1.my_select {}
#   p array1.my_count(){|n| n.even?}
#   p array1.my_map {|n| n*n}
#   p array1.my_map! {|n| n*n}
#   p array2.my_each{|elem| puts "#{elem} =  #{elem[0]}" }
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