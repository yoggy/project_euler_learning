#!/usr/bin/ruby
require 'pe_mylib'
desc "自身が素数で右から順に切り詰めても、左から順に切り詰めても全部素数になる数の総和は？"

# 作戦 : 全部で11こあるらしいので、11個目が出現するまで繰り返してみる？

require 'prime_table'

def check(n)
  #puts "========================="
  #puts n
  return false unless n.prime? 

  # 右を削る
  a = n.to_a
  (a.size-1).times {
    a.pop
    tmp = a.join.to_i
    #puts tmp
    return false unless tmp.prime? 
  }

  # 左側を削る
  a = n.to_a
  (a.size-1).times {
    a.shift
    tmp = a.join.to_i
    #puts tmp
    return false unless tmp.prime? 
  }

  true
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
