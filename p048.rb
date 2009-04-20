#!/usr/bin/ruby
require 'pe_mylib'
desc "1**1 + 2**2 + 3**3 + .... + 1000**1000の最後の10桁の数字は？"

total = 0
(1..1000).each{|n|
  total += n ** n
}

str = total.to_s
last10 = str[str.size - 10, 10]

# 結果の出力
puts "result = #{last10}"
