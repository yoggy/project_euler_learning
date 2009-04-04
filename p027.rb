#!/usr/bin/ruby
require 'pe_mylib'
desc "abs(a)<1000, abs(b)<1000の条件で、n**2+a*n+bで最長の素数の数列を生成するa,bの積は？"

# 作戦:a,bはおそらく素数じゃね？

# 生成する素数の数列の長さを返す
def prime_length(a, b)
  n = 0
  length = 0
  loop {
    v = n**2 + a * n + b
    break if v == 0 || v.prime? == false
    n += 1
    length += 1
  }
  length
end

# 素数列を1000以下求める
primes = cache_calc("primes_under_1000") {
  pg = Prime.new
  primes = []
  loop {
    p = pg.succ
    break if p >= 1000
    primes << p
  }
  primes
}

seeds = primes
seeds += primes.map{|n| -n}
seeds += [-1, 1]
seeds.sort!

# テスト
#puts prime_length(1, 41)     # => 40
#puts prime_length(-79, 1601) # => 80

# 総当たりで検索
max_length = 0
max_a = 0
max_b = 0
seeds.each{|a|
  seeds.each{|b|
    l = prime_length(a, b)
    if l > max_length
      puts "hit!! : a=#{a}, b=#{b}, length=#{l}"
      max_length = l
      max_a = a
      max_b = b
    end
  }
}

# 結果の出力
puts "result = #{max_a*max_b}"
