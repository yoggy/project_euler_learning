#!/usr/bin/ruby

require 'pe'
desc "1000未満の数のうち、3または5の倍数である数の合計を求める"

total = 0
(1..999).each{|n|
  if n%3 == 0 || n%5 == 0
    total += n
  end
}


puts "total = #{total}"
