#!/usr/bin/ruby
require 'pe_mylib'
desc ""

$str = "0"
$count = 0

#
def d(n)
  if $str.size - 1 < n
    loop {
      $count += 1
      $str += $count.to_s
      break if $str.size - 1 >= n
    }
  end
  $str[n,1].to_i
end

(0..6).each{|i|
  n = 10 ** i
  pp "d=#{n}, num=#{d(n)}"
}

rv = 1
(0..6).each{|i|
  n = 10 ** i
  rv *= d(n)
}

# 結果の出力
puts "result = #{rv}"
