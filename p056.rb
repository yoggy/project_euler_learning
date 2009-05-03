#!/usr/bin/ruby
require 'pe_mylib'
desc ""

n = 100
max = 0

(1...n).each {|a|
  (1...n).each {|b|
    r = a**b
    t = r.to_a.sum
    #puts "#{a}**#{b} : t=#{t} ,r=#{r}"
    max = t if t > max
  }
}

# 結果の出力
puts "result = #{max}"
