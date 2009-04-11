#!/usr/bin/ruby
require 'pe_mylib'
desc "100万未満で10進数でも2進数でも回文になる数の総和は？"

# 注：先頭が0になる数は含めない

# とりあえず回文になる10進数の数を作って、
# それが2進数で回文になっているかどうかをチェックする？

def check(n)
  false
end

pp check(1)   #1
pp check(3)   #11
pp check(9)   #1001
pp check(585) #1001001001

__END__

max_digit = 3
total = 0

(1..max_digit).each{|digit|
  half_digit = (((digit+1))/2).to_i
  puts "digit = #{digit}, half_digit=#{half_digit}"

  min = 10**(half_digit-1) 
  max = 10**(half_digit) - 1
  puts "min=#{min}, max=#{max}"

  (min..max).each{|hn|
    hs = hn.to_s
    numstr = ""
    if digit == 1
      num_str = hs
    elsif digit % 2 == 0
      # 偶数の場合の数字の作り方
      num_str = hs + hs.reverse
    else
      # 奇数の場合の数字の作り方
      num_str = hs + hs.reverse[1, hs.size-1] # 対称な文字列を作る
    end
    num = num_str.to_i

    if check(num)
      puts "hit!! #{num}"
      total += 1
    end
  }
}

# 結果の出力
puts "result = #{total}"
