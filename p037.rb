#!/usr/bin/ruby
require 'pe_mylib'
desc "自身が素数で右から順に切り詰めても、左から順に切り詰めても全部素数になる数の総和は？"

# 作戦 : 全部で11こあるらしいので、11個目が出現するまで繰り返してみる？

require 'prime_table'

def check(n)
  false
end

# 
count = 0
total = 0

prime = Prime.new 
loop {
  p = prime.succ
  next if p.digit == 1

  if check(p)
    puts "hit!!! p=#{p}"
    total += p
    count += 1
    break if count == 11
  end
}

rv = "not implemented..."
puts "result = #{total}"
