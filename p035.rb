#!/usr/bin/ruby
require 'pe_mylib'
desc "100万未満で巡回素数はいくつあるか？"

# 巡回素数とは、桁を回転させて生成した数がいずれも素数である数のこと
# 197 -> 971 -> 719

# とりあえず100万未満の素数について総当たりするしか方法ないかなぁ...?

def rotate(str)
  return str if str.size <= 1

  a = str.unpack('c*')
  x = a.shift
  a.push x
  a.pack('c*')
end


# 巡回素数かどうかをチェックする関数
def check(n)
  check = true
  str = n.to_s
  n.to_s.size.times {
    unless str.to_i.prime?
      check = false
      break
    end
    str = rotate(str)
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
