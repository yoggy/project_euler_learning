#!/usr/bin/ruby
require 'pe'
desc "1901/1/1から2000/12/31の間に月の始まりが日曜日は何日ある？1900/1/1は月曜日はじまり。"

require 'date'

total = 0
(1901..2000).each {|y|
  (1..12).each{|m|
    d = Date.new(y, m, 1)
    total += 1 if d.wday == 0
  }
}

# 結果の出力
puts "result = #{total}"
