#!/usr/bin/ruby
require 'pe'
desc ""

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
names.sort!
names.each_with_index {|name,i|
  alpabet_score = 0
  name.each_byte {|b|
    alphabet_score += b - 'a'[0] + 1
  }
  score = alphabet_score * (i + 1)
  puts "#{i} : #{name} alphabet_score=#{alphabet_score} score=#{score}"
}

# 結果の出力
rv = "not implemented..."
puts "result = #{rv}"
