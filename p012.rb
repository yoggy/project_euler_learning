#!/usr/bin/ruby
require 'pe'
desc "最初に約数が500を超えるtriangle numberは？"

# ここ以下にプログラム書く
count = 0
tn = 0  # triangle number

loop {
  count += 1
  tn += count

  # 約数の数は素因数分解した素数の数から求める
  # prime_divisionは素数とその数を配列で表した結果を返すので
  # それを利用する。
  # 28 -> [[2, 2], [7, 1]] -> 2が3パターン(0,1,2) * 7が2パターン(0,1) -> (2+1)*(1+1)
  fn = 1 # 約数
  tn.prime_division.each {|p|
    fn *= p[1]+1
  }
  puts sprintf("count = %d, tn = %d, fn=%d", count, tn, fn)

  break if fn > 500
}

# 結果の出力
puts "result = #{tn}"
