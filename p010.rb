#!/usr/bin/ruby
require 'pe'
desc "200万未満の素数の合計はいくつ？"

# ここ以下にプログラム書く
total = 0
p = Prime.new
loop {
 n = p.succ
 print "n=#{n}"
 break if n >= 2000000
 total += n
 puts ", total=#{total}"
}
puts

# 結果の出力
puts "result = #{total}"
