#!/usr/bin/ruby
require 'pe_mylib'
desc "xに対して2,3,4,5,6倍してもxと同じ数字を含む一番小さい正の整数は？ただしxと同じ桁に同じ数字があるケースは除く"

# 問題では例として次の例が挙げられている
#  125874 * 2 = 251748
#    同じ数字が出現している
#    同じ数字は違う桁に出現している

# 探索範囲
#   見つかるまで
#
# 列挙
#   順番に？
#   同じ数字が出現しないなら、[1,2,3,4,5,6,7,8,9,0].choice_and_call(6)で列挙？
#   
# 効率
#   「異なる桁に出現すること」とx6までの条件を満たすためには、最低6桁の数字であるはず。
#      異なる6カ所の数が出現するから
#    
#    上限は10桁？ 0〜9までの数字を入れ替えることを考えるとが10桁が限界？
#
#    xは1から始まる数のはず。2から始まる数だとx5したときに全体の桁が代わり
#    新しい数が入ってくるから
#

def check(src_a, max)
  src_i = src_a.join.to_i
  (2..max).each{|m|
    # m倍する
    r_i = src_i * m
    r_a = r_i.to_a

    # 同じ数が出現しているかチェック
    return false unless r_a.sort == src_a.sort

    # 同じ桁に同じ数がないかチェック
    r_a.each_with_index {|d, i|
      return false unless d == r_a[i]
    }
  }

  true
end

# for test...
pp check([1,2,5,8,7,4], 2) #true
pp check([1,2,5,8,7,4], 3) #true
pp check([1,2,5,8,7,5], 2) #false


# 結果の出力
rv = "not implemented..."
puts "result = #{rv}"
