#!/usr/bin/ruby
require 'pe_mylib'
# Find the smallest cube for which exactly five permutations of its digits are cube.
desc ""

n = 344
hit_count = 5
rv = nil

catch(:loop) {
  loop {
    n += 1
    t = n ** 3 
  
    a = [t]
    t.to_a.choice_and_call {|d|
      next if d[0] == 0
  
      # 数を組み立て直す
      t2 = d.join.to_i
  
      #  1/3乗する
      t3 = t2 ** (1/3.0) #Rationalを指定すると1になってしまうので注意。。
      ti = t3.round
      tf = (t3 - ti).abs
  
      if tf < 0.000000001 && !a.include?(t2)
        a << t2
      end
    }
    puts "n=#{n}, t=#{t}, count=#{a.size}"
  
    if a.size == hit_count
      puts "hit!!! n=#{n}, a=#{a.pretty_inspect.chomp}"
      rv = t
      throw :loop
    end
  }
}

# 結果の出力
puts "result = #{rv}"

