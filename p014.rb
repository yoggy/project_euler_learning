#!/usr/bin/ruby
require 'pe'
desc "100万以下の数字からはじめるコラッツ数列のなかで一番長いものは？"

$dist = {}

def calc_dist(n)
  return 0 if n <= 1

  return $dist[n] if $dist.key?(n)

  d = -1
  if n%2==0
    d = calc_dist(n/2) + 1
  else
    d = calc_dist(3*n+1) + 1
  end

  $dist[n] = d
  d
end

puts "make table..."
max_n = 0
max_d = 0
(1..1000000).each{|n|
  d = calc_dist(n)
  if d >= max_d
    max_d = d
    max_n = n
    puts "max_n = #{max_n}, max_d=#{max_d}"
  end
}

# 結果の出力
puts "result = #{max_n}"
