#!/usr/bin/ruby
require 'pe_mylib'
desc "2つの過剰数(positive integer)の和で表現できない数の合計はいくつ？"

# memo: 28123より大きな数は2つの過剰数の和で表現できるらしい

# とりあえず過剰数を求める
pi = cache_calc("positive_integer_under_28123") {
 (2..28123).inject([]) {|r, n|
    total = n.proper_divisors.inject {|t, i|
      t + i
    }
    if total > n
      #puts "#{n} : #{total}"
      r << n
    end
    r
  }
}
pp pi

# 結果の出力
rv = "not implemented..."
puts "result = #{rv}"
