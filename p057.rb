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
# とりあえず189って出たけど正解じゃないみたい。
# RubyのRationalクラスは約分するからダメなのか？
#

limit = 1000
count = 0
a_pre = Rational(1, 2) #1回目の値

(2..limit).each{|n|
  a_now = Rational(1, 2 + a_pre)
  sqrt2 = 1 + a_now 
  puts "#{n} = #{sqrt2}"

  if sqrt2.numerator.digit > sqrt2.denominator.digit
    puts "hit!! n=#{n}, (#{sqrt2.numerator.digit}/#{sqrt2.denominator.digit}) #{sqrt2} (#{sqrt2.to_f})"
    count += 1
  end

  a_pre = a_now
}

puts "result = #{count}"
