#!/usr/bin/ruby
require 'pe_mylib'
desc "2<=a<=100,2<=b<=100のa**bの組み合わせでユニークな数はいくつある？"

map = {}
min = 2
max = 100 
(min..max).each {|a|
  (min..max).each {|b|
    map[a**b] = true
  }
}

# 結果の出力
puts "result = #{map.size}"
