#!/usr/bin/ruby
require 'pe_mylib'
desc "螺旋状に1から数字を1001x1001配列したとき、対角線上にある数字の合計は？"

# 作戦:ぐるぐる回って4隅の合計を求めて行く

total = 0
width = 1
max_width = 1001

loop {
  # 角にある数
  cornar = []

  # コーナー右上の数を求める
  n = width * width
  cornar << n

  # width>=3の場合は4隅あるので残りを計算
  if width >= 3 
    (1..3).each {|i|
      # 右上から数を減らしていって、左上、左下、右下を求める
      cornar << n - ((width-1) * i)
    }
  end

  # 4隅の合計を加算
  total += cornar.sum

  # 1辺の幅は2ずつ大きくなる
  width += 2
  break if width > max_width
}

# 結果の出力
puts "result = #{total}"
