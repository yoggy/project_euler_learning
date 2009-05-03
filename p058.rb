#!/usr/bin/ruby
require 'pe_mylib'
desc "時計回りに数を並べていって対角線上に存在する数が素数である割合が10%以下になる辺の長さは？"

#
# p028.rbと似ている問題
# 作戦としては、角の数が素数かどうかを判定してその数のカウントだけを保持
# p028.rbは配列を持っていてsumしていたので、ちょっと効率わるかったかな...?
#
# 素数かどうかを判定する際に、数がprime_table.rbで取り扱えない範囲にあるため
# OpenSSLの確率的素数判定を使用することにした
#
#  ruby -ropenssl -e 'puts OpenSSL::BN.new("982451653").prime?(0)'
#

require 'openssl'

# 3からはじめる
width = 3

prime_num = 0
cornar_count = 1

rv = 0

loop {
  cornar_count += 4

  # 右下の角の数が素数かどうかチェック
  n = width * width
  prime_num += 1 if OpenSSL::BN.new(n.to_s).prime?(0)

  # 残りの隅を計算
  (1..3).each {|i|
    # 右下から数を減らしていって、左上、左下、右上を求める
    c = n - ((width-1) * i)
    prime_num += 1 if OpenSSL::BN.new(c.to_s).prime?(0)
  }

  # 素数の割合を計算
  if prime_num / cornar_count.to_f < 0.1
    puts "hit!!! #{width} : #{prime_num} / #{cornar_count} #{prime_num / cornar_count.to_f * 100}%"
    rv = width
    break
  end

  # 1辺の幅は2ずつ大きくなる
  width += 2
}

# 結果の出力
puts "result = #{rv}"
