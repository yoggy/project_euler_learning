#!/usr/bin/ruby
require 'pe_mylib'
desc "10000未満でLychal数はいくつあるか？"

# Lychal数とは、自身とreverseした数を足し合わせる操作を続けたときに回文数が出現しない数のこと
#
# 問題ではLychal数ではない数の例として以下の例が載っている
#   47 + 74 = 121
#
#   349  + 943  = 1292
#   1292 + 2921 = 4213
#   4213 + 3124 = 7337
#   回文数ではないときは、次にその数を使って同様の操作を行い、回文かどうかをチェックする
#
# 問題では、10000以下の数なら50回未満の操作で見つからなければOKと仮定しているみたい。
#
# とりあえず、いい方法を思いつかないからとりあえずまじめに実装してみるか。。
#

class Integer
  def even?
    return true if self%2 == 0
  end

  def odd?
    return true if self%2 == 1
  end

  # 回文数かどうかチェック
  def palindromic?
    a = self.to_a
    h = []
    t = []
    half_size = (a.size/2).to_i
    if a.size.even?
      h = a[0, half_size]
      t = a[half_size, half_size]
    else
      h = a[0, half_size]
      t = a[half_size+1, half_size]
    end

    return true if h == t.reverse
    false
  end

  #
  def lychal?(limit)
    a = self
    b = a.to_a.reverse.join.to_i

    limit.times {|i|
      c = a + b
      if c.palindromic?
        return false 
      end
      
      a = c
      b = a.to_a.reverse.join.to_i
    }
    
    true
  end
end

#
# main
#
count = 0
max = 10000

(1..max).each{|n|
  count += 1 if n.lychal?(50)
}

# 結果の出力
puts "result = #{count}"

