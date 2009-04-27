#!/usr/bin/ruby
require 'pe_mylib'
desc "1<=n<=nの範囲でC(n, r)が100万を超える数はいくつあるか？"

class Integer
  def fact
    (1..self).to_a.inject(1) {|r, n| r * n}
  end
end

def comb(n, r)
  n.fact / r.fact / (n-r).fact
end

count = 0
(1..100).each {|n|
  (1..n).each{|r|
    c = comb(n, r)
    puts "comb(#{n}, #{r})=#{c}"
    count += 1 if c >= 1000000
  }
}

# 結果の出力
puts "result = #{count}"
