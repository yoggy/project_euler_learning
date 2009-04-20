#!/usr/bin/ruby
require 'pe_mylib'
desc "連続する4つの数を取り出し、それらの数の因数がすべて異なるケースの最小の数は？"

# 例では2つと3つのケースがあげられている
#
# 2つの場合
#   14 = 2 * 7
#   15 = 3 * 5
#
# 3つの場合
#   644 = 2**2 * 7 * 23
#   645 = 3 * 5 * 43
#   646 = 2 * 17 * 19
#
# いつも考えるポイント
#   列挙
#     2から順番に
#   効率
#     効率いい方法を思いつかないので総当たり作戦？
#   探索範囲
#     初めに該当する数が見つかるまで
#

num = 4
pos = 2

loop_flag = true
loop do
  ns = (pos..pos + num-1).inject([]) {|r, n|
    r << n
  } 

  # 因数判定
  factors = {}
  clean_flag = true
  ns.each {|n|
    # まず因数がnumと同じかどうかを判定
    ps = n.prime_division
    if ps.size != num
      clean_flag = false 
    end

    # 次に同じ因数がないかどうかを判定
    n.prime_division.each {|p|
      f = p[0] * p[1]
      clean_flag = false if factors.key?(f)
      factors[f] = true
    }
  }

  if clean_flag
    puts "hit!!! pos=#{pos}"
    break
  end

  pos += 1
  if pos % 10000 == 0
    puts "pos = #{pos}"
  end
end


# 結果の出力
puts "result = #{pos}"
