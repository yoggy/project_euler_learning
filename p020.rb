#!/usr/bin/ruby
require 'pe_mylib'
desc "100!の各桁の合計は？"

total = (1..100).inject(1){|r,n|r*n}.to_s.split(/ */).map{|s|s.to_i}.inject(0){|t,n|t+n}

# 結果の出力
puts "result = #{total}"
