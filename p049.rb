#!/usr/bin/ruby
require 'pe_mylib'
desc "4桁の数字3つで構成される等差数列で(1)3つとも素数である(2)1つの数は各桁の数字の入れ替えると残り2つの数を表すことができる。を満たす数を連結した数字は？"

# 注意: 例で示されている1487, 4817, 8147では無いもう一つの数が答えになる。

# 範囲
#   1000〜9999
# 列挙方法
#   1000<p<9999の素数を列挙
#
# 効率
#   (1)素数だけを対象に調べる
#   (2)等差数列を構成しているかどうか？
#   (3)3つの数字の各桁で使用されている数字が同じかどうか？
#

require 'prime_table'

$check_hash = {}
(0..9).each {|i|
  $check_hash[i] = 0
}

def check_hash
  $check_hash.dup
end

prime = Prime.new
ps = []
loop do
  p = prime.succ
  break if p > 9999
  ps << p if 1000 <= p && p <= 9999
end

p = []
pp ps.choice_and_call(2) {|n|
  p[0] = n[0]
  p[1] = n[1]
  d = n[1] - n[0]
  p[2] = n[1] + d

  if p[2].prime?
    s =  p.map {|i| i.to_s.unpack("c*").sort.pack("c*")}
    if s[0] == s[1] && s[1] == s[2]
      puts "hit!!! #{p.pretty_inspect.chomp} diff=#{d}"
      next if p[0] == 1487 && p[1] == 4817 && p[2] == 8147
      break;
    end
  end
}


# 結果の出力
puts "result = #{p.join}"
