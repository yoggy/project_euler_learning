#!/usr/bin/ruby
require 'pe_mylib'
desc "a**2 + b**2 = c**2, a + b + c = 1000, a < b < cを満たすabcの積は？"

(1..1000).each{|a|
  (a+1..1000).each{|b|
    c = 1000 - a - b
    if a**2 + b**2 == c**2
      puts "hit a=#{a}, b=#{b}, c=#{c}"
      puts "product a*b*c = #{a*b*c}"
    end
  }
}

