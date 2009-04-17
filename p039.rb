#!/usr/bin/ruby
require 'pe_mylib'
desc "直角三角形の辺の長さをa,b,cとし辺の周囲長(a+b+c)をpとする。p=120の時は解が3つ存在するが、p<=1000の範囲で解の数が最大になるのはpがいくつの時？"

# 問題の例としてp=120の時に、{20,48,52}, {24,45,51}, {30,40,50}が示されている

# 考え中メモ
#
#  直角三角形のそれそれの辺をa,b,cとすると、以下の関係を満たす
#   a**2 + b**2 = c**2
#   a <= b, a + b < cとする。
# 
#  問題を考える手順
#    どうやって順番に列挙するか？
#    効率よく列挙するためには？
#    探索範囲は？
#
#  「ピタゴラス数」でググるといろいろ引っかかる様子
#
#   原始ピタゴラス数の作り方
#     * http://ja.wikipedia.org/wiki/%E3%83%95%E3%82%A7%E3%83%AB%E3%83%9E%E3%83%BC%E3%81%AE%E6%9C%80%E7%B5%82%E5%AE%9A%E7%90%86
#     a,b,cが互いに素であるピタゴラス数のことを原始ピタゴラス数という
#     互いに素な正の整数m,nに対して、一方が偶数の時、a,b,cは次の式で求めることができる
#
#       a = |m**2 - n**2|
#       b = 2 * m * n
#       c = m**2 + n ** 2
#
#    今回の問題の答えはa,b,cが互いに素でないケースも含むのかどうか？
#
#    ピタゴラス数は倍数になっている話
#      * http://club.pep.ne.jp/~asuzui/page13.html
#      (1)aまたはbは3の倍数である。(2)aまたはbは4の倍数である。(c)a,b,cのどれかは5の倍数である
#
#    n**2+(2n+1)=(n+1)**2 を使ったピタゴラス数の求め方
#      * http://mathmuse.sci.ibaraki.ac.jp/naosuke/pynumber.html
#      * 2n+1が平方数であればa=2n+1, b=sqrt(2n+1), c=n+1のピタゴラス数になる
#        * この式はn**2 + 2n + 1を素因数分解した結果の(n+1)**2
#    
#    どうもピタゴラス数を生成する行列というのがあるらしい
#      * http://www.geocities.jp/ikuro_kotaro/koramu/635_p.htm
#      * http://www.amazon.co.jp/dp/4860641973/
#      * [3,4,5]の既約ピタゴラス数から始めると、既約ピタゴラス数だけを生成する様子
#      * 1つの親から3つの子ができる
#

require 'matrix'
class Matrix
  def mul(array)
    self * Matrix.rows([array]).transpose
  end
end

# ピタゴラス数を生成するマトリックス
$m = Matrix[[-1,-2, 2],[-2,-1, 2],[-2,-2, 3]]

# 初期値
seed = [3,4,5]

pp $m.mul([-3,4,5])

def push_result(p)
  $ps << p
end

# ピタゴラス数を作る
def calc_child(p)
  v = Matrix[[-p[0],  p[1],  p[2]], [-p[0], -p[1],  p[2]], [ p[0], -p[1],  p[2]]].transpose
  c = ($m * v).transpose
  [c.row(0).to_a, c.row(1).to_a, c.row(2).to_a]
end

# ピタゴラス数のFIFOバッファ
buf = [seed]

# 1000以下のピタゴラス数の配列
ps = [seed]

# 既約ピタゴラス数をどんどん生成して、1000以下の物をすべて列挙
# 親をバッファから取り出し、求めた3つの子をバッファに追加することで
# 幅優先探索を行う。
#
# マトリックスは無限にピタゴラス数を生成するが、
# 1000以下にしぼっているので、どこかで止まるはず？
loop {
   break if buf.size == 0

   parent = buf.shift
   childs = calc_child(parent)
   childs.each{|c|
     if c.sum <= 1000
       buf << c
       ps << c
     end
   }
}

pp ps

# 既約ピタゴラス数だけしか作らないっぽいので
# (da)**2 + (db)**2 = (dc)**2を計算する
ps.each{|p|
  d = 2
  loop {
    pd = p.map{|a| a*d}
    break if pd.sum > 1000
    ps << pd
    d += 1
  }
}

# pの集計を行う
p_map = {}
ps.each{|p|
  s = p.sum
  p_map[s] = 0 unless p_map.key?(s)
  p_map[s] += 1
}

# 一番多いところを探す
max = 0
max_p = 0
ps.each{|k,v|
  if v > max
    max = v
    max_p = k
  end
}

# 結果の出力
puts "result = #{max_p}"
