#!/usr/bin/ruby
require 'pe_mylib'
desc "1/d(dは1000未満)のうち、一番長い循環小数の周期は？"

# 作戦としては次の通り
# f(n)を入力されたnに対して1/nを求め、循環小数だった場合、循環の周期を返す関数とする
# nは1以上の整数とする
#
# f(n)の計算方法は次の2パターン存在する
#
#   (a) nが素数でない場合
#
#      f(n) = max(f(p0), f(p1), ... , f(pi))
#
#      * p0,p1...piはnの素因数
#      * max()はf(p0)...f(pi)のうち、最大の数を返す関数とする
#
#      上記の定理は手計算で確認
#        この定理より、最大の周期を求めるだけなら、(b)の素数のケースのみ考えれば良いことになる。 
#
#   (b) nが素数の場合 
#
#     10**x ≡ 1 (mod n)を満たすxがf(n)の答え。
#
#     この定理については以下のURLを参考にした
#       http://www004.upp.so-net.ne.jp/s_honma/mathbun/mathbun36.htm
#

#
max = 0

# 結果の出力
rv = "not implemented..."
puts "result = #{rv}"
