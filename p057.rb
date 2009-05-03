#!/usr/bin/ruby
require 'pe_mylib'
desc "ルート2を連分数で表現していく際、1000回までの近似操作の途中で、分母の桁よりも分子の桁が大きくなる数はいくつあるか？"

# ルート2は次のような連分数で近似していくことができる
#   1 + 1/2 = 3/2 = 1.5
#   1 + 1/(2 + 1/2) = 7/5 = 1.4
#   1 + 1/(2 + 1/(2 + 1/2) = 17/22 = 1.41666...
#   1 + 1/(2 + 1/(2 + 1/(2 + 1/2)) = 41/29 = 1.41379...
# 
# 8回目で1393/985になり、はじめて分母の桁よりも分子の桁数が大きくなる
# 1000回のiteration中でこのような数はいくつあるか？が問題
#
# この近似式は次のように変形できる
#
#   A = 1 + a
#   a0 = 1/2
#   a1 = 1/(2 + a0)  
#   a2 = 1/(2 + a1)
#   a3 = 1/(2 + a2)
#       :
#       :
# これで近似していけば1000回ぐらいは余裕？
#
# とりあえずRationalクラスを使って計算したら
# 189って出たけど正解じゃないみたい。
# RubyのRationalクラスは勝手に約分するからダメなのか？
#
# ということで自力で約分しない方法を考える。
#
# a0 = an0 / ad0とすると…
#
#   a1  = 1/(2 + an0/ad0)
#       = ad0 / (ad0 * 2 + an0)
#   an1 = ad0           # 分子
#   ad1 = ad0 * 2 + an0 # 分母
#
#   A1  = 1 + a1
#       = 1 + an1/ad1
#       = (ad1 + an1) / ad1
#   An1 = ad1 + an1
#   Ad1 = ad1
#
# 約分せずに計算し続けるのが正解だった
#

limit = 1000
count = 0
an_pre = 1 #1回目の値
ad_pre = 2

(2..limit).each{|n|
  an_now = ad_pre
  ad_now = ad_pre * 2 + an_pre

  sqrt2_n = ad_now + an_now
  sqrt2_d = ad_now

  #puts "#{n} = #{sqrt2_n}/#{sqrt2_d}"

  # 桁が大きくてlog10が使えないので、文字列の長さで桁数の比較をする
  if sqrt2_n.to_s.size > sqrt2_d.to_s.size
    puts "hit!! n=#{n}, (#{sqrt2_n.to_s.size}/#{sqrt2_d.to_s.size})"
    count += 1
  end

  an_pre = an_now
  ad_pre = ad_now
}

puts "result = #{count}"
