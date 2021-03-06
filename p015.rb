#!/usr/bin/ruby
require 'pe_mylib'
desc "20x20の格子状の道で左上から右下までたどるルートは何通りあるか？"

# 問題としては40ビットのうち20ビットを立てるのは何通りあるか？という問題と同じ。
# 右を1、下を0と置き換えるとわかりやすい？

# 問題としては組み合わせ 40C20 = (40*39*38*...*21)/20! を計算するのと同じ
a = 1
(21..40).each{|n|
  a *= n
}

b = 1
(1..20).each{|n|
  b *= n
}

rv = a/b
puts "result = #{rv}"
