#!/usr/bin/ruby
require 'pe_mylib'
desc ""

# m**nを考える
count = 0

n = 1
loop {
  puts "n=#{n}"
  m = 1
  m_count = 0
  loop {
    a = m ** n
    puts "#{m}**#{n} = #{a}(digit #{a.digit})"

    if a.digit == n
      puts "hit!! #{m}**#{n} = #{a}(digit #{a.digit})"
      m_count += 1
      count += 1
    elsif a.digit > n
      break
    end

    m += 1
  }

  puts "finish #{n}"
  n += 1

  # 1つも見つからない場合は終わり
  break if m_count == 0 
}

# 結果の出力
puts "result = #{count}"
