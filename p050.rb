#!/usr/bin/ruby
require 'pe_mylib'
desc "100万未満の素数で、連続する素数の和で表現できる素数のうち、一番長い項で表現される素数は何？"

# 例では100未満までのケース41 = 2 + 3 + 5 + 7 + 11 + 13と、
# 1000未満の場合、953が21項で表現できると書いている

# いつも考える攻略ポイント
# 探索範囲
#   100万未満の素数
#
# 列挙
#   素数の列挙
#   素数の和でどうやって表現するか？の列挙方法を考える必要がある
#
# 効率
#   素数自身が素数の和で表されるか？の判定を、どうやって効率よく判定するかを考える
# 
require 'prime_table'

# 探索範囲の上限
max_p = 1000000

# 先にmax_pまでの素数を集めておいて高速化
prime = Prime.new
$target_p = []
loop {
  p = prime.succ
  break if p >= max_p
  $target_p << p
}

# 与えられた素数を連続した素数の和に変換する関数
def check(p, max_i)
  max_length = 0
  a = []

  # 作戦
  #   (1) 合計がpより多くなるまで数の小さい素数から足していく
  #       この操作でもしpが一致したらhit!
  #   (2) はみ出したら、小さい数からpをはみ出さないように切り捨てていく
  #       この操作でもしpが一致したらhit!
  #   (3) もしpより小さくなったときは(1)に戻る

  si = 0
  ei = 0
  total = 2

  loop {
    #puts "p=#{p}, si=#{si} => #{$target_p[si]}, ei=#{ei} => #{$target_p[ei]} total=#{total}"
    if p == total
      return ei - si + 1 #長さの範囲を返す
    elsif p > total
      ei += 1
      total += $target_p[ei]
    elsif p < total
      total -= $target_p[si]
      si += 1
    end
  }
end

# 順に探索
max_a = []
max_t = 0
max_p = 0
$target_p.each_with_index{|p, i|
  t = check(p, i)

  if t >= max_t
    max_t = t
    max_p = p
    puts "hit!!! #{p} => #{max_t}"
  end

  if i % 10000 == 0
    puts "p=#{p}"
  end
}

# 結果の出力
puts "result = #{max_p}"
