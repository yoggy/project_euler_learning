#!/usr/bin/ruby
require 'pe_mylib'
# Find the smallest cube for which exactly five permutations of its digits are cube.
desc ""

n = 0
hit_count = 5
rv = nil

map = {}

catch(:loop) {
  loop {
    n += 1
    t = n ** 3 
    sort_t = t.to_a.sort.join #0を含めるので文字列のままにしておく
    
    map[sort_t] = [] unless map.key?(sort_t)
    map[sort_t] << t

    if map[sort_t].size == hit_count
      puts "hit!!! #{map[sort_t].pretty_inspect}"
      rv = map[sort_t].sort[0]
      throw :loop
    end
  }
}

# 結果の出力
puts "result = #{rv}"

