#!/usr/bin/ruby
require 'pe_mylib'

# How many hands did player one win in the game of poker?
desc "ポーカーでplayer1が勝つのはいくつあるか？"

# 手札の組を以下のURLからダウンロードして、これを元に勝敗を考える
# http://projecteuler.net/project/poker.txt

url = "http://projecteuler.net/project/poker.txt"
text = read_from(url)

def eval_cards(cards)
  pp cards

  # 役と一番大きな数を返す
  [1,2]
end

pattern = []
text.each_line{|l|
  l.chomp!
  a = l.split(" ")
  pattern << [a[0,5], a[5,5]]
}

count = 0
pattern.each{|p|
  v = p.map{|c| eval_cards(c)}
  if v[0][0] > v[1][0]
    count += 1
  elsif v[0][0] == v[1][0]
    puts "even"
  else
    puts "lose"
  end
}

# 結果の出力
puts "result = #{count}"
