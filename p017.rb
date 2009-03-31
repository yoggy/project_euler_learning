#!/usr/bin/ruby
require 'pe'
desc "1から1000までの数をアルファベットで記述すると何文字になる？"

# 数字テーブル
$table_1_9 = %w(one two three four five six seven eight nine)
$table_10_19 = %w(ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
$table_20_90 = %w(twenty thirty forty fifty sixty seventy eighty ninety)

# 100-999までの数を文字列に変換
def d2a_1_999(n)
  raise "invalid number...n=#{n}" if n < 1 || 999 < n
  return d2a_1_99(n) if 1 <= n && n <= 99

  # ex. one handred and twenty one
  d3 = (n / 100).to_i
  d2 = n % 100

  s = d2a_1_9(d3) + " " + "hundred"
  s += " and " + d2a_1_99(d2) unless d2 == 0
  s
end

# 1-99までの数を文字列に変換
def d2a_1_99(n)
  raise "invalid number...n=#{n}" if n < 1 || 99 < n
  return d2a_1_9(n) if 1 <= n && n <= 9

  # 10-99までの文字列生成
  s = ""
  case n
    when 10..19
      s = $table_10_19[n-10]
    when 20..99
      d2 = n / 10
      s = $table_20_90[d2 - 2]

      d1 = n % 10
      s += " " + d2a_1_9(d1) unless d1 == 0
  end
  s
end

# 1-9までの数を文字列に変換
def d2a_1_9(n)
  raise "invalid number...n=#{n}" if n <=0 || 9 < n
  $table_1_9[n-1]
end

# 1-1000までの数を文字列に変換
def d2a(n)
 s = ""
 case n
   when 1..999
     s = d2a_1_999(n)
   when 1000
     s = "one thousand"
   else
     raise "invalid number...n=#{n}"
 end
 s 
end

str = ""
(1..1000).each{|n|
  str += d2a(n) + "\n"
}

# for debug...
#puts str

# 空白を詰める
str.gsub!(/[\s\n\t]+/, "")

# 結果の出力
puts "result = #{str.size}"

