#!/usr/bin/ruby
require 'pe_mylib'
desc "100万未満で10進数でも2進数でも回文になる数の総和は？"

# 注：先頭が0になる数は含めない

# とりあえず回文になる10進数の数を作って、
# それが2進数で回文になっているかどうかをチェックする？

def check2(n)
end

ns = %w(0 1 2 3 4 5 6 7 8 9)
max_digit = 4

(1..max_digit).each{|d|
  a = ns
  half_d = (((d+1))/2).to_i - 1
  half_d.times{a = a.product(ns)}
  if half_d == 0
    a = a.map{|p| [p]} 
  else
    a = a.map{|p| p.flatten} 
  end
  pp a

  if d%2 == 0
    # ex.d = 4の場合
    # ns[0] ns[1] ns[1] ns[0]の数を生成

  else
    # ex.d = 5の場合
    # ns[0] ns[1] ns[2] ns[1] ns[0]の数を生成
  end
}

# 結果の出力
rv = "not implemented..."
puts "result = #{rv}"
