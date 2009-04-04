#!/usr/bin/ruby
require 'pe_mylib'
desc "2つの過剰数(abundant number)の和で表現できない数の合計はいくつ？"

# memo: 28123より大きな数は2つの過剰数の和で表現できるらしい

# とりあえず過剰数を求める
require 'set'
ans = cache_calc("positive_integer_under_28123") {
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
ans_set = ans.inject(Set.new) {|r, n|
  r << n
}

# 最小の数24から28123まで総当たりで調べるw
total = 0
(1..28123).each{|n|
  check = false
  ans.each{|an|
    # step1: nより小さい数を見つける
    break if an >= n 

    # step2: n - an に該当する過剰数があるかどうかチェック
    if ans_set.include?(n - an)
      #puts "check = true : n=#{n} an_step1=#{an}, an_step2=#{n-an}"
      check = true
      break;
    end
  }
  unless check
    puts "hit!!! : n=#{n}"
    total += n
  end
}


# 結果の出力
puts "result = #{total}"
