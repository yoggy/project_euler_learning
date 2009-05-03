#!/usr/bin/ruby
require 'pe_mylib'
desc "XORで暗号化されたデータを復号し、そのASCIIの合計を求める"
#
# 問題では3バイトの鍵を使ってXORしているみたい
# 3文字の小文字
#
# 効率良さそうな作戦を思いつかないので、まじめにbrute forceするか...
#
# 手順
#   (1) 鍵を順に作成
#   (2) 復号
#   (3) ASCIIの範囲に入っているかどうかチェック
#
# (3)だけだと終了判定が弱いなぁ。該当する物がいっぱい出てくる...
#
#

url = "http://projecteuler.net/project/cipher1.txt"
str = read_from(url).strip
payload = str.split(",").map {|c| c.to_i}

def decrypt(payload, key)
  rv = []
  payload.each_with_index {|c, i|
    rv << (c ^ key[i%3])
  }
  rv
end

class Array
  def ascii?
    # asciiの範囲に入っているかどうかチェック
    self.each {|c|
      return false if c < 32 || 126 < c
    }
    true
  end

  def score
    # 文章になっているかどうかの判定
    # ちょっとセコいけど、文字列中に"word"という文字列があればOKとするw
    str = self.pack("C*")
    return 1 if str.scan(/Word/).size > 0
    0
  end
end

key = []
canditate = []
hit_flag = false
("a"[0].."z"[0]).each {|a|
  ("a"[0].."z"[0]).each {|b|
    ("a"[0].."z"[0]).each {|c|
      key = [a,b,c]
      text = decrypt(payload, key)
      if text.ascii? 
        canditate << [text.score, text]
      end
    }
  }
}

# 0はscore, 1はtext
rv = canditate.inject([0,""]) {|r, t|
  if t[0] > r[0] 
    r[0] = t[0]
    r[1] = t[1].pack("C*")
  end
  r
}

pp rv

# 結果の出力
puts "result = #{rv[1].sum}"
