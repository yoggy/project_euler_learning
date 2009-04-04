#!/usr/bin/ruby
require 'pe_mylib'
desc "1p,2p,5p,10p,20p,50p,£1(100p),£2(200p)硬貨を使って£2にできる組み合わせは何通り？"

$curs = [200,100,50,20,10,5,2,1]

def find_pattern_rec(max_cur, n)
  p = 0
  $curs.each{|c|
    # 一度小さい硬貨を選択したら、その後の再帰でそれ以上大きな硬貨は選ばない。重複を避けるため。
    next if c > max_cur

    d = n - c
    next   if d < 0 
    p += 1 if d == 0
    p += find_pattern_rec(c, d) if d > 0
  }
  p
end

def find_pattern(n)
 find_pattern_rec($curs[0], n)
end

p = find_pattern(200)

puts "result = #{p}"
