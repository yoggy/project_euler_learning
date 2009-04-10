#!/usr/bin/ruby
require 'pe_mylib'
desc "100万未満で巡回素数はいくつあるか？"

# 巡回素数とは、桁を回転させて生成した数がいずれも素数である数のこと
# 197 -> 971 -> 719

# とりあえず100万未満の素数について総当たりするしか方法ないかなぁ...?

# 巡回素数かどうかをチェックする関数
def check(n)
  
end

count = 0
max = 100
prime = Prime.new

loop {
  p = prime.succ
  if p >= max break

  count += 1 if check(p)
}

# 結果の出力
puts "result = #{count}"
