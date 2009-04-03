#!/usr/bin/ruby
require 'pe_mylib'
desc "n=100の時の(1+2+3+..n)**2 - 1**2+2**2+3**2+...+n**2の差はいくつ？"

# ループで計算する際、前に計算した合計を使って高速化する作戦
count = 0
a = 0
b = 0
diff = 0

loop {
  count += 1
  aa = count ** 2
  bb = count

  a += aa
  b += bb
  diff = b**2 - a 

  break if count >= 100
}
puts "diff = #{diff}, count = #{count}"

