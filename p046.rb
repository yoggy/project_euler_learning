#!/usr/bin/ruby
require 'pe_mylib'
desc "素数と二乗した数の2倍で表すことができない奇数の合成数で一番小さい数は？"

# 問題では次のような例が挙げられている
#
# 奇合成数  素数  二乗の2倍
#   9     =  7  + 2 * 1^(2)
#   15    =  7  + 2 * 2^(2)
#   21    =  3  + 2 * 3^(2)
#   25    =  7  + 2 * 3^(2)
#   27    =  19 + 2 * 2^(2)
#   33    =  31 + 2 * 1^(2)
# このパターンが当てはまらなくなるのはどこ？というのが問題
#
# いつも考えるポイント
#   列挙方法
#     * 列挙するもの : 奇数の合成数, 素数, 2*(n**2)の数
#
#   効率
#     * 奇数の合成数をどうやって列挙するか？
#     * Christian Goldbachの予想した数に一致しているかどうかの判定
#       * (a) 素数の列挙
#       * (b) s*(n**2)の列挙
#       * たぶん(b)を順に試していって、残りが素数かどうか判定した方が早そう？
#         * (a)よりも(b)の方が早く大きな数になる
#
#   探索範囲
#     * 1つ見つかるまで
#

# 素数判定を高速化
#require 'prime_table'

# 奇数の合成数のスタートは9から
nc = 9

loop {
  # 奇数で素数でない物を奇数の合成数とする
  if nc.prime?
    nc += 2
    next
  end

  # 2*n**2で順に引いていく
  clean_flag = false
  n = 1
  ts = 0
  loop {
    ts = 2 * (n ** 2)
    break if nc <= ts

    #puts "    #{nc} = #{nc - ts} + 2 * (#{n}**2)"

    if (nc - ts).prime?
      clean_flag = true
      break
    end

    n += 1
  }
  unless clean_flag 
    puts "hit!! #{nc}"
    break
  end

  nc += 2  # 奇数を探索
  if (nc-1)%10000 == 0
    puts "nc = #{nc}"
  end
}

# 結果の出力
puts "result = #{nc}"
