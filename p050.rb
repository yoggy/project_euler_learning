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
max_p = 1000

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
  rv = []

  start_i = 0
  while start_i <= max_i
    len = max_i - start_i + 1
    hit_flag = false
    (start_i..max_i).each{|end_i|
      a = $target_p[start_i..end_i]
      sum = a.sum

      # 超えた場合はそれ以上探索しない
      break if p < sum 

      #
      if p == sum
        hit_flag = true
        rv = a
        #puts "  #{p} => #{a.pretty_inspect}"
        break
      end
    }
    break if hit_flag
    start_i += 1
  end
  rv
end

# 順に探索
max_a = []
max_t = 0
max_p = 0
$target_p.each_with_index{|p, i|
  a = check(p, i)

  if a.size >= max_t
    max_t = a.size
    max_a = a
    max_p = p
    puts "hit!!! #{p} => [#{a.join(',')}]"
  end

  if i % 10000 == 0
    puts "i=#{i}"
  end
}

# 結果の出力
puts "result = #{max_p}"
