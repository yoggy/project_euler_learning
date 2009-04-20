#!/usr/bin/ruby
require 'pe_mylib'
desc "100万未満の素数で、素数の和で表現できる素数のうち、一番長い項で表現される素数は何？"

# 例では1000未満の場合、953が21項で表現できると書いている

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

# 与えられた数が素数の和で表現できるかどうか？

#
#
#
#require 'prime_table'

max_p = 100

# max_pまでの素数を集める
prime = Prime.new
$target_p = []
loop {
  p = prime.succ
  break if p >= max_p
  $target_p << p
}

# 0の時は表現できないケース
def check(p, i)
  puts "p=#{p}, target_p[#{i}]=#{$target_p[i]}"
  loop {
    d = p - $target_p[i]
    return 1 if d == 0
    next if d < 0

    child_t = check(d, i - 1)
    if child_t > 0
      return child_t + 1 if child_t > 0
    end
    i -= 1
    return 0 if i < 0
  }
end

pp check(41, $target_p.index(41) - 1)

__END__

# 順に探索
max_t = 0

target_p.each_with_index{|tp, i|
  next if i == 0

  max_pos = i - 1
  t = check(tp, i-1)
  next if t == 0

  if t >= max_t
    max_t = t
    puts "hit!!! tp=#{tp}, t=#{t}"
  end
}

# 結果の出力
puts "result = #{max_t}"
