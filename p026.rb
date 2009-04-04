#!/usr/bin/ruby
require 'pe_mylib'
desc "1/d(dは1000未満)のうち、一番長い循環小数の周期を持つdは？"

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
#      上記の定理は手計算で確認。あくまで予想w
#        この定理より、最大の周期を求めるだけなら、(b)の素数のケースのみ考えれば良いことになる。 
#
#   (b) nが素数の場合 
#
#     10**x ≡ 1 (mod n)を満たすxがf(n)の答え。
#
#     この定理については以下のURLを参考にした
#       http://www004.upp.so-net.ne.jp/s_honma/mathbun/mathbun36.htm
#

def recurring_cycle_digit(n)
  # メモ：循環小数の循環節の長さは、既約分数の分母よりも小さくなる様子
  #      参考: http://ja.wikipedia.org/wiki/%E5%BE%AA%E7%92%B0%E5%B0%8F%E6%95%B0

  # xの部分は1000桁ぐらいだったら何も考えずにbrute forceでw
  (1..n).each{|d|
    #puts "#{n} => #{d},#{(10**d)},#{((10**d) - 1) % n}"
    if (10**d) % n == 1
      return d
    end
  }
  # ヒットしなかった場合はとりあえず0にしておく？
  0
end

#
max = 0
prime = Prime.new
loop {
 p = prime.succ
 break if p >= 1000
 d = recurring_cycle_digit(p)
 max = p if d > max
 puts "#{p} : #{d}"
}

# 結果の出力
puts "result = #{max}"
