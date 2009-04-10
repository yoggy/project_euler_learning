#!/usr/bin/ruby
require 'pe_mylib'
desc "100万未満で巡回素数はいくつあるか？"

# 巡回素数とは、桁を回転させて生成した数がいずれも素数である数のこと
# 197 -> 971 -> 719

# とりあえず100万未満の素数について総当たりするしか方法ないかなぁ...?

def rotate(n)
  # とりあえず整数のみ考える
  a = n.to_s.unpack('c*')
  return n if a.size <= 1

  x = a.shift
  a.push x
  a.pack('c*').to_i
end


# 巡回素数かどうかをチェックする関数
def check(n)
  check = true
  p = n
  n.to_s.size.times {
    check = false unless p.prime?
    p = rotate(p)
  }
  check
end

count = 0
max = 1000000
prime = Prime.new

loop {
  p = prime.succ
  break if p >= max
  if check(p)
    puts "hit!! p=#{p}"
    count += 1
  end
}

# 結果の出力
puts "result = #{count}"
