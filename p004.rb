#!/usr/bin/ruby
require 'pe'
desc "3桁の数を掛け合わせてできるpalindromic number(回文になっている数)の中で一番大きな数は？"

p_num = 0;
(100..999).each{|i|
  (100..999).each{|j|
    p = i * j
    p_str = p.to_s
    if p_str == p_str.reverse && p > p_num
      p_num = p
    end
   }
}
puts p_num

