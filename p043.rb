#!/usr/bin/ruby
require 'pe_mylib'
desc ""

def check(a)
  d8 = a[7,3].join.to_i
  return false if d8 % 17 != 0

  d7 = a[6,3].join.to_i
  return false if d7 % 13 != 0

  d6 = a[5,3].join.to_i
  return false if d6 % 11 != 0

  d5 = a[4,3].join.to_i
  return false if d5 % 7 != 0

  d4 = a[3,3].join.to_i
  return false if d4 % 5 != 0

  d3 = a[2,3].join.to_i
  return false if d3 % 3 != 0

  d2 = a[1,3].join.to_i
  return false if d2 % 2 != 0

  true
end

# 問題に出ていた例
pp check([1,4,0,6,3,5,7,2,8,9])
pp check([1,2,3,4,5,6,7,8,9,0])

count = 0
total = 0

# ここ以下にプログラム書く
[1,2,3,4,5,6,7,8,9,0].choice_and_call {|a|
  #0が先頭に選ばれるのは最後だからbreakして終わる
  break if a[0] == 0

  if check(a)
    pp "hit!! #{a.join}"
    total += a.join.to_i
  end
  
  count += 1
  if count % 100000 == 0
    puts "count =#{count}"
  end
}


# 結果の出力
puts "result = #{total}"
