#!/usr/bin/ruby
require 'pe_mylib'
desc "5つの素数の組み合わせの中から任意の2つの素数を取り出し、任意の順番で連結しても素数になる素数の組で合計が最小のものは？"

#
# 問題では例として次の4組の素数が紹介されている
#
# 3, 7, 109, 673
#
#    3,   7 -> 37, 73
#    3, 109 -> 3109, 1093
#    3, 673 -> 3673, 6733
#    7, 109 -> 7109, 1097
#    7, 673 -> 7673, 6737
#  109, 673 -> 109673, 673109
#
# 合計が小さい数順で探索するように方法を工夫しないとだめかも。。
# Array.choice_and_callのアルゴリズムだと最後の桁が配列の最後の要素まで探索してしまうのでダメ。。
#
# 例:2つ選ぶ場合
#   1,2,3,4,5,6,7
#   1,2
#   1,3
#   2,3
#   1,4
#   2,4
#   3,4
#
# 例:3つ選ぶ場合
#   1,2,3,4,5,...
#   1,2,3
#   1,2,4
#   2,3,4
#   1,2,5
#   1,3,5
#   1,4,5
#   2,3,5
#   2,4,5
#   3,4,5
#
# ...というか普通に考えたら673(素数の122番目)までを総当たりして5つ選んでいたら
#
#   c(122,5) = 207288004
#
# なので、ちょっと総当たり回数が多すぎるような気がする。
# 別の方法を考えた方がよさげ...
#
# 例えば、3, 7, 109, 673に何か1つ数字を加えた物が答えの組じゃないか？と想像
#
#   2つの場合 -> 3, 7
#   3つの場合 -> 3, 7, 109
#   4つの場合 -> 3, 7, 109, 673
#   5つの場合 -> 3, 7, 109, 673, ?
#       :
#       :
# という感じで構成されているんじゃないか？ということで検証してみる
# 
# 1500万ぐらいまでの素数で検証してみたけど、5つの場合は
# 3,7,109,673に何か数を加えた物ではないっぽい...
#
#   a = [3, 7, 109, 673]
#   loop {
#     p = prime.succ # 673の次から開始
#     puts "hit!!" a.map{|n| join_prime?(n, p)}.inject(true) {|r,n| r && n}
#   }
# これで試してみたけど、1500万以下ではヒットしなかった。。
#
# 答えの5つの数をa,b,d,c,eとして、check([a,b,c,d,e])が判定用関数だとすると、少なくとも
#
#   check([a,b,c,d]) = true
#   check([a,b,c])   = true
#   check([a,b])     = true
#   check([a])       = true   #何もくっつけない
#
# であるはず。ということは、3, 7, 109, 673ではない次の組み合わせを探す必要あり。
# 良く考えたら「ダメだから次」という判断はどうやってするの？？
#
# 上限を決めて探索していくのはどうだろ？
#   * a > e > d > c > bという条件をつける
#   * aを決める
#   * a以下のcheck([a,b])を満たすbをチョイス
#     * bは小さい順から取得
#   * b以下のcheck([a,b,c])を満たすcをチョイス
#     * cはbよりも大きい一番小さな素数を選ぶ
#        :
#   * 無かったらaを次の素数に進める
#  

require 'prime_table'

# 前と後ろに連結して、どちらも素数であるかどうかを判定する
def join_prime?(a, b)
  return false unless (a.to_s + b.to_s).to_i.prime?
  return false unless (b.to_s + a.to_s).to_i.prime?
  true
end

# 入力された数字の配列が問題の条件を満たすかどうかチェックする関数
def check(a)
  return a.prime? if a.size == 1
  a.combination(2).each{|a,b|
    return false unless join_prime?(a,b)
  }
  true
end

# とりあえず素数を10000個用意
prime_table = []
prime = Prime.new
10000.times {
  prime_table << prime.succ
}

# 探索
rv = []
catch(:loop) {
  (3..prime_table.size).each {|ia|
    a = prime_table[ia]
    ib = 0

    loop {
      b = prime_table[ib]

      if check([a,b])
        ic = ib + 1
        if ic < ia
          loop {
            c = prime_table[ic]
  
            if check([a,b,c])
              id = ic + 1
              if id < ia
                loop {
                  d = prime_table[id]

                  if check([a,b,c,d])
                    ie = id + 1
                    if ie < ia
                      loop {
                        e = prime_table[ie]

                        if check([a,b,c,d,e])
                          puts "hit!!! #{[a,b,c,d,e].pretty_inspect}"
                          rv = [a,b,c,d,e]
                          throw :loop
                        end

                        ie += 1
                        break if ie == ia
                      }
                    end
                  end

                  id += 1   
		          break if id == ia 
                }
              end
            end
          
            ic += 1
		    break if ic == ia 
          }
        end
      end

      ib += 1
      break if ib == ia
    }
  }
}

puts "result = #{rv.sum}"

