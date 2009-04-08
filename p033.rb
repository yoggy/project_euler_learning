#!/usr/bin/ruby
require 'pe_mylib'
desc ""

# メモ：
#   (1) 1以下になる分子・分母は共に2桁の数を生成する
#       * 100x100から少し減らせそう？
#       * ac/cb またはca/bcのパターン？
#         * 除去する数がc、残る分子がa、残る分母がb
#           * (2)より
#         * a < bである必要性。これを満たさないと1以下にならない
#         * ac/cbのときはa>0,c>0,b>0である必要あり
#           * a=0 or c=0だと2桁を満たさない。
#           * 除去した際にb=0だと分母が0になるのでb>0である必要あり
#         * ac/cbのときも同じくa>0,c>0,b>0である必要あり
#         * a = b = cを満たす組み合わせはなし。1になってしまう
#         * 少し考えたけど、ac/bc,ca/cbのパターンはなさそう
#         * a!=b, b!=c, a!=cじゃないか？
#       * 分子・分母は最大公約数が1より大きい
#         * 最大公約数が1だと約分できる形ではない
#
#   (2) 分子・分母に共通する数字を取り除く
#       * 取り除き方は分子が10の位から除去したら、分母は1の位から除去する
#       * 分子が1の位から除去したら、分母は10の位から除去する
#       * 10/30 -> 1/3という自明な約分は行わないようにするため
#
#   (3) 元の分数を約分した分数と、除去した分数が同じならnon-trivialな分数
#       * 問題文によると、4つあるらしい
#
#   (4) 最後に求めた分数を約分した形で、積を求め、その分母が答え
#
#
#   49/48 -> 4/8
#

def check1(a,b,c)
  nm  = a * 10 + c
  dnm = c * 10 + b
  org = Rational(nm,dnm)

  nm  = a
  dnm = b

  tmp = Rational(nm,dnm)

  return true if tmp == org && org >= tmp

  false
end

def check2(a,b,c)
  nm  = c * 10 + a
  dnm = b * 10 + c
  org = Rational(nm,dnm)

  nm  = a
  dnm = b

  tmp = Rational(nm,dnm)

  return true if tmp == org && org >= tmp

  false
end

rv = []
#
[1,2,3,4,5,6,7,8,9].combination(2).each{|e|
  a = e[0]
  b = e[1]
  (1..9).each {|c|
     #puts "a=#{a} b=#{b} c = #{c}"
     if check1(a,b,c)
       puts "hit! (type 1)" 
       r = Rational(a*10+c,c*10+b)
       rv << r
       puts "a=#{a} b=#{b} c = #{c}, #{a}#{c}/#{c}#{b} => #{r}"
     end

     if check2(a,b,c)
       puts "hit! (type 2)" 
       r = Rational(c*10+a,b*10+c)
       rv << r
       puts "a=#{a} b=#{b} c = #{c}, #{c}#{a}/#{b}#{c} => #{r}"
     end
  }
}

# 
puts "result = #{rv.mult.denominator}"
