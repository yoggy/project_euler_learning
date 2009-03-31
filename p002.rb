#!/usr/bin/ruby
require 'pe'
desc "フィボナッチ数列のうち、400万までの数＆偶数の数の合計は？"

# ループでフィボナッチ数列を求めて高速化する作戦
a = 1
b = 2
total = 2

while b < 4000000
  c = b + a
  #puts "#{a}, #{b}, #{c}"
  total += c if c%2 == 0
  a = b
  b = c
end
puts "total = #{total}"

