#!/usr/bin/ruby
require 'pe'
desc "1から20で割り切れる数の中で一番小さい数は？"

# ステップ数を大きくして高速にする作戦。。
m = 1*2*3*5*7*11*13*17*19

count = m
loop {
  check = true
  (1..20).each{|i|
    #puts sprintf("i=%d count=%d", i, count)
    if count%i != 0
      check = false
      break
    end
  }
  break if check == true
  count += m
}
puts count
