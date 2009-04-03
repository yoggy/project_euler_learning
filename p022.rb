#!/usr/bin/ruby
require 'pe_mylib'
desc "ファイルにある名前の名前スコアの合計は？"

# 名前1件あたりの名前スコアとは、文字スコアと順番スコアを掛け合わせたもの。
# 順番スコアは1番目にあれば1、100番目にあれば100
# 文字スコアとはアルファベットAは1、Bは2...Zは26とし、名前に含むアルファベットの数を合計した値
# 例:COLINは938番目にある -> 名前スコア = (3 + 15 + 12 + 9 + 14) * 938 = 49714 となる

# ファイルの準備
url = "http://projecteuler.net/project/names.txt"
filename = File.basename(url)
unless File.exist? filename
  require 'open-uri'
  open(url, 'r') {|r|
    open(filename, 'w') {|w|
      w.syswrite(r.read)
    }
  }
end

# ファイル読み込み
# ファイルはCSV形式で1行に収まっている
require 'csv'
names = CSV.read(filename)[0]

# ソート
total = 0
names.sort!
names.each_with_index {|name,i|
  # 1件あたりの文字スコアを計算
  alphabet_score = 0
  name.each_byte {|b|
    alphabet_score += b - 'A'[0] + 1
  }

  # 名前スコア = 文字スコア*順番スコア
  score = alphabet_score * (i + 1)
  #puts "#{i} : #{name} alphabet_score=#{alphabet_score} score=#{score}"

  total += score
}

# 結果の出力
puts "result = #{total}"
