#!/usr/bin/ruby
require 'pe'
desc "10000未満の友愛数の和は？"

n = 10000

# 約数の合計を返す関数
$table = {}
def d(n)
  return $table[n] if $table.key?(n)
  div = n.divisor
  div.pop # 自分自身は含まない
  $table[n] = div.inject {|r, a| r + a}
  $table[n]
end

# また総当たりで調べるか…
total = 0
(2...n).each{|i|
  j = d(i)
  tmp_i = d(j)
  if i == tmp_i && i != j  #完全数は含まない
    puts "hit #{i}, #{j}"
    total += j
  end
}

# 結果の出力
puts "result = #{total}"
