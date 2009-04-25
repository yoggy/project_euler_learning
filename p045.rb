#!/usr/bin/ruby
require 'pe_mylib'
desc "一番初めに出現する3角数,5角数,6角数を満たす数は40755である。次に出現するこの条件を満たす数は？"

# 問題には一番初めに出現する例が示されている
# t(285) = p(165) = h(143) = 40755

#   Triangle     t(n) = n(n+1)/2    1, 3, 6, 10, 15, ...
#   Pentagonal   p(n) = n(3n−1)/2   1, 5, 12, 22, 35, ...
#   Hexagonal    h(n) = n(2n−1)     1, 6, 15, 28, 45, ...

# 作戦
#   何も考えないのなら、h(n)を求めてその数がt,pであるかを判定した方が
#   探索は早そう？

def t(n)
  n * (n + 1) / 2
end

def t?(v)
 n = (-1 + sqrt(1 + 8 * v)) / 2
 return true if n == n.to_i
 false
end

def p(n)
  n * (3 * n - 1) / 2
end

def p?(v)
 n = (1 + sqrt(1 + 24 * v)) / 6
 return true if n == n.to_i
 false
end

def h(n)
  n * (2 * n - 1)
end

# test...
#(1..5).each{|n| pp t(n) }
#(1..20).each{|v| puts "#{v} = #{t?(v)}" }
#pp
#
#(1..5).each{|n| pp p(n) }
#(1..20).each{|v| puts "#{v} = #{p?(v)}" }
#pp
#
#(1..5).each{|n| pp h(n) }
#pp

# 探索ループ
n = 2
rv = 0
loop {
  v = h(n)
  if p?(v) && t?(v)
    puts "hit!!! n=#{n}, v=#{v}"
    
    # 一番初めに見つかるのは無視。2番目を探す
    if v != 40755
      rv = v
      break
    end
  end
  if n % 10000 == 0
    puts "n=#{n}, v=#{v}"
  end
  n += 1
}

# 結果の出力
puts "result = #{rv}"

