#!/usr/bin/ruby
require 'pe_mylib'

# How many hands did player one win in the game of poker?
desc "ポーカーでplayer1が勝つのはいくつあるか？"

# 手札の組を以下のURLからダウンロードして、これを元に勝敗を考える
# http://projecteuler.net/project/poker.txt

def read_from(url)
  filename = File.basename(url)

  unless File.exist?(filename)
    system("wget -O#{filename} #{url}")
  end

  text = ""
  open(filename, 'r') {|f|
    text = f.read
  }
  text
end

url = "http://projecteuler.net/project/poker.txt"
text = read_from(url)

pp text

# 結果の出力
rv = "not implemented..."
puts "result = #{rv}"
