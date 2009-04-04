#!/usr/bin/ruby
require 'pe_mylib'
desc "各桁の数字を5乗した和が元の数と同じになる数の総和は？"

max_digit = 5
min = 2
max = 10**(max_digit+1)-1 # 探索範囲は本当にこれでいいのか疑問。99999までだと194979がヒットしない

rv = []

(min..max).each{|n|
  total = 0
  n.each_digit {|d|
    total += d ** max_digit
  }
  if n == total 
    puts "hit! n=#{n}"
    rv << n
  end
}


# 結果の出力
puts "result = #{rv.sum}"
