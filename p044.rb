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

# indexとnをあわせるために、ダミーで先頭に0を入れておく
$penta_table = [0, 1]
$penta_hash  = {}

def penta(n)
  if $penta_table.size-1 < n
    ($penta_table.size-1..n).each{|i|
       $penta_table[i] = i * (3 * i - 1) / 2
       $penta_hash[$penta_table[i]] = true
    }
  end
  $penta_table[n]
end

def penta?(n)
  loop {
    # 配列のinclude?は遅いので、ハッシュを使って判定を早くする
    return $penta_hash.key?(n) if $penta_table.size-1 >= n

    # テーブルを1増やす
    penta($penta_table.size)
  }
end

i = 2
loop_flag = true
while loop_flag
  j = i - 1
  while j > i/2   # あまり離れているところには無いと予想w
    pi = penta i
    pj = penta j
    #puts "i=#{i},j=#{j},pi=#{pi},pj=#{pj}"
    s = pi + pj
    d = pi - pj

    # 差の方はキャッシュに乗ってるはずなので、こっちの判定を先にした方が高速？
    if penta? d
      puts "hit!!!!! diff i=#{i},j=#{j},pi=#{pi},pj=#{pj}, diff=#{d}"
      if penta? s
        puts "hit!!!! sum i=#{i},j=#{j},pi=#{pi},pj=#{pj}, sum=#{s}"
        loop_flag = false
        break
      end
    end
    j -= 1
  end

  i += 1
end


# 結果の出力
rv = "not implemented..."
puts "result = #{rv}"
