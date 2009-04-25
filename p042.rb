#!/usr/bin/ruby
require 'pe_mylib'
desc "triangle wordな単語はいくつある？"

# triangle numberとは、t(n) = 1/2*n*(n+1)で表される数
# triangle wordとは、SKY = 19+11+25=55=t(10)という感じでアルファベットの合計がtriangle numberである単語
#

url = "http://projecteuler.net/project/words.txt"
filename = File.basename(url)

unless File.exist?(filename) 
  system("wget #{url}")
end

def score(str)
  total = 0
  str.each_byte{|b|
    total += b - 'A'[0] + 1
  }
  total
end

def triangle_num?(src)
  n = 1
  t = 1
  loop { 
    if t < src
      n += 1
      t = n * (n + 1) / 2
    elsif src == t
      return true
    else # t > src
      return false
    end
  }
end

require 'csv'
words = CSV.read(filename)[0]

count = 0
words.each{|w|
  s = score(w)
  if triangle_num?(s)
    puts "hit!! w=#{w} s=#{s}"
    count += 1
  end
}

# 結果の出力
puts "result = #{count}"
