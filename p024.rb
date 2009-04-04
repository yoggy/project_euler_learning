#!/usr/bin/ruby
require 'pe_mylib'
desc "0,1,2,3,4,5,6,7,8,9を並び替えた時に、辞書順に100万番目に来る文字列は？"

$count = 0

# 引数はいままで選択したパターンと、その残りの配列
def choice_rec(path, tail)
  # 再帰の終了条件
  if tail.size == 1
    $count += 1
    if $count == 1000000
      # ここで終了する
      rv = path + tail
      puts "result = #{rv.join("")}"
      STDOUT.flush
      exit 0
    end
    return [tail]
  end

  # 
  pattern = []
  tail.each_with_index{|h, i|
    # 選択したところとそこを抜いた配列を作成
    tail_sub = tail.dup
    tail_sub.delete_at(i)

    # 取り除いた残りで再帰。配列で複数パターンが帰ってくる
    c = choice_rec(path + [h], tail_sub) 

    # 再帰で求めた部分と先頭を組み合わせてパターンに入れる
    c.each{|p|
      a = [h] + p
      pattern << a
    }
  }
  pattern
end

def choice(ary)
  pattern = choice_rec([], ary)
end

pp choice([0,1,2,3,4,5,6,7,8,9])
