#!/usr/bin/ruby
require 'pe_mylib'
desc "5角数の数列から数を2つ取り出し、そのの和,差がまた5角数である組をみつけ、その中から差が最小になる2つの5角数の差は？"

# 5角数とは？
# p(n) = n * (3 * n - 1) / 2で生成される数列。p(1)=1から始まる
# http://ja.wikipedia.org/wiki/%E4%BA%94%E8%A7%92%E6%95%B0
#
# 作戦
#   どうやって組み合わせを列挙するか?
#
#   効率よく見つけるには？
#
#   探索範囲は？
#     順に列挙可能であれば、一番初めに見つかる差が5角数の組み合わせになる？？
#
#   j
#   |    /
#   |  /
#   |/ この範囲を探す
#   +-------->i
#
#
#  i>jの範囲で探す
#    D = |p(i) - p(j)|なので、i<jのケースは探さない
#    またi==jの場合も探さない
#
#  i   (i,j)のペア
#  2 -> 2 1
#  3 -> 3 2, 3 1
#  4 -> 4 3, 4 2, 4 1
#  5 -> 5 5, 5 4, 5 3, 5 2, 5 1
#    ...
#  逆順に列挙するのは、差が小さい順になると予想しての探索？？
#
#  この方法はダメ。i,jが1000を超えたあたりから遅くなりすぎる。。。
#
#  次に、先にDを想定して、そこから逆算する方法を考える
#
#  (1) 5画数のdを1つ決める。そのときd=p(l)とする
#  (2) d - p(j) = p(l) - p(j) = p(i)であるかどうかをloopしてチェック。jはl-1から1までを探す
#  (3) (2)が見つかったら、p(i)+p(j)=p(k)かどうかチェック
#

# indexとnをあわせるために、ダミーで先頭に0を入れておく
$penta_table = [0, 1]
$penta_hash  = {}

def penta(n)
  if $penta_table.size-1 < n
    ($penta_table.size-1..n).each{|i|
       $penta_table[i] = i * (3 * i - 1) / 2
       $penta_hash[$penta_table[i]] = i
    }
  end
  $penta_table[n]
end

def get_n_from_penta(p)
  return -1 unless penta?(p)
  $penta_hash[p]
end

def penta?(n)
  loop {
    #pp n
    #pp $penta_table
    # 配列のinclude?は遅いので、ハッシュを使って判定を早くする
    return $penta_hash.key?(n) if $penta_table.size-1 >= n

    # テーブルを1増やす
    penta($penta_table.size)
  }
end

l = 2
pl = 0

loop_flag = true
while loop_flag
  pl = penta(l)
  j = l - 1
  while j > l/2 
    pj = penta(j)
    pi = pl + pj
    #puts "i=#{get_n_from_penta(pi)}, j=#{j}, l=#{l}, pi=#{pi}, pj=#{pj}, pl=#{pl}"
    if penta?(pi) && pi != pj
      puts "hit!!! diff i=#{get_n_from_penta(pi)}, j=#{j}, l=#{l}, pi=#{pi}, pj=#{pj}, pl=#{pl}"
      pk = pi + pj
    if penta? pk
      puts "hit!!! sum i=#{get_n_from_penta(pi)}, j=#{j}, k=#{get_n_from_penta(pk)}, pi=#{pi}, pj=#{pj}, pk=#{pk}"
      loop_flag = false
      break
      end
    end
    j -= 1
  end
  l += 1
end

# 結果の出力
puts "result = #{pl}"
