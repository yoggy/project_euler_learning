#!/usr/bin/ruby
require 'pe_mylib'
# Find the smallest cube for which exactly five permutations of its digits are cube.
desc ""

n = 0
$rv = nil

catch(:loop) {
  loop {
    n += 1
    t = n ** 3 
    puts "n=#{n}, t=#{t}"
  
    count = 0
    a = [t]
    t.to_a.choice_and_call {|d|
      next if d[0] == 0
  
      # 数を組み立て直す
      t2 = d.join.to_i
  
      #  1/3乗する
      t3 = t2 ** (1/3)
      ti = t3.truncate
      tf = t3 - ti
  
      if tf < 0.0001 && !a.include?(t2)
        count += 1
        a << t2
      end
    }
  
    # 自身を含むので-1しておく
    if count == 2
      puts "hit!!! a=#{a.pretty_inspect.chomp}"
      $rv = t
      throw :loop
    end
  }
}

# 結果の出力
puts "result = #{$rv}"

