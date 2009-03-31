#!/usr/bin/ruby
require 'pe'
desc "2*1000を求め、各桁の数値を合計した値は？"

total = 0
(2**1000).to_s.each_byte{|n|
  # each_byteはasciiコードで値がくるので、数値に変換して計算する
  total += n - '0'[0]
}


# 結果の出力
puts "result = #{total}"
