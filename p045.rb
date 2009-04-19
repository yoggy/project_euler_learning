#!/usr/bin/ruby
require 'pe_mylib'
desc "一番初めに出現する3角数,5角数,6角数を満たす数は40755である。次に出現するこの条件を満たす数は？"

# 問題には一番初めに出現する例が示されている
# t(285) = p(165) = h(143) = 40755

#   Triangle     t(n) = n(n+1)/2    1, 3, 6, 10, 15, ...
#   Pentagonal   p(n) = n(3n−1)/2   1, 5, 12, 22, 35, ...
#   Hexagonal    h(n) = n(2n−1)     1, 6, 15, 28, 45, ...

# 結果の出力
rv = "not implemented..."
puts "result = #{rv}"
