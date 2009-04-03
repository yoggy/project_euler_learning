#!/usr/bin/ruby

require 'pe_mylib'
desc "1000未満の数のうち、3または5の倍数である数の合計を求める"

total = (1..999).inject(0) {|t, n|
  n%3 == 0 || n%5 == 0 ? t + n : t
}

puts "total = #{total}"
