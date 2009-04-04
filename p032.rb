#!/usr/bin/ruby
require 'pe_mylib'
desc "ここに問題文を書く"

# ここ以下にプログラム書く

# 引数は次の通り
#   ary 数字を入れた配列
#   pos どこで区切るか？の位置を示す配列
#       0番目は*を入れる位置。1番目は=を入れる位置
def calc(ary, pos, debug=false)
  a = ary[0,pos[0]].join.to_i
  b = ary[pos[0], pos[1]-pos[0]].join.to_i

  puts "#{a} * #{b} = #{a*b}" if debug
  return a * b
end

def check(ary, pos)
  c = ary[pos[1], ary.size-pos[1]].join.to_i
  return true if calc(ary, pos) == c
  false
end

nums = [1,2,3,4,5,6,7,8,9]
pos = [1,2,3,4,5,6,7,8]

#
# 数字のならびのどこに*と=を入れるか？を列挙する
#
tmp_comb = pos.combination(2)

pos_comb = [] # *と=の位置
len_comb = [] # a,bの桁数

tmp_comb.each {|p|
  # a*b=cと分離した際の各数字の文字列の長さを求める
  a = p[0]
  b = p[1] - p[0]
  c = nums.size - p[1] 
  #puts "#{a} #{b} #{c}"

  # あり得ない組み合わせの場合は除去する
  # 1桁 * 1桁 = 7桁 とかはあり得ないので...
  # 2桁 * 3桁の場合、4桁もしくは5桁なら正しい
  if a + b == c || a + b - 1 == c
    #puts "hit #{a} #{b} #{c}"
    
    # 次に、a,bの長さが以前登場したものなら列挙しない
    flag = true
    len_comb.each {|v|
      if v[0] == b || v[1] == a
        flag = false
        break
      end
    }
    if flag 
      pos_comb << p
      len_comb << [a, b]
    end
  end
}

#pp pos_comb
#pp len_comb

match_comb = []

nums.choice_and_call {|a|
  pos_comb.each {|p|
    if check(a, p)
      puts "hit! : #{a.pretty_inspect.chomp} #{p.pretty_inspect.chomp}"
      match_comb << [a,p]
    end
  }
}

# 積が同じになるものがあるので、重複を避ける
rv = []
match_comb.inject(0) {|r, a|
  c =  calc(a[0], a[1], true)
  rv << c unless rv.include?(c)
}

puts "result = #{rv.sum}"
