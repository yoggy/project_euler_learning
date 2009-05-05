#!/usr/bin/ruby
require 'pe_mylib'
#Find the sum of the only set of six 4-digit figurate numbers with a cyclic property.
desc "4桁の多角数で巡回的である6つの数の合計は？多角数は3,4,5,6,7,8角数を1つづつみたしていること"

# 問題では8128,2882,8281が挙げられている
#
#   8128 -(28)-> 2882 -(82)-> 8281 -(81)-> 8128
#
# 問題の「巡回的」とは4桁の前半2桁と後半2桁が一致して集合がつながっていること。
# 最後の数->最初の数も含む。
#
# また8128,2882,8281はP(3,127)=8128, P(4,91)=8281, P(5,44)=2882を満たしている
#
# 多角数の求め方一覧
#    3角数 n * (n + 1) / 2
#    4角数 n**2
#    5角数 n * (3 * n - 1) / 2
#    6角数 n * (2 * n - 1)
#    7角数 n * (5 * n - 3) / 2
#    8角数 n * (3n - 2)
#
# とりあえず、まじめに計算したらどれぐらいの数があるのか調べてみる
# 4桁の多角数の個数は以下の通り
#
#      3角数: 96
#      4角数: 68
#      5角数: 56
#      6角数: 48
#      7角数: 43
#      8角数: 40
#
#  あと巡回的な組を見つける際、とくに順番は決まっていないので...
#
#    3角数 -> 4角数 -> 5角数 -> ... -> 3角数
#    3角数 -> 5角数 -> 6角数 -> ... -> 3角数
#
#  と3角数を始点・終点と決めると、残りの5つの数の順番の組み合わせを考慮する必要がある。
#  順番についての組み合わせは5!=120通り。
#  
#  まじめに総当たりすると3621755289600通り。このオーダーでは総当たりはちょっと無理...
#
#    96 * 68 * 56 * 48 * 43 * 40 * 120 = 3621755289600
#
#  でも、全部の組み合わせを試す訳ではなく、途中のつながりでダメで探索が終わるケースが
#  ほとんどのような気がする。
#  8角数を始点・終点にして探して行くか？
#
#  あと、多角数の10の位が0の数は次が無いので、これは削れる？
#
#    8008 -(08)-> 08??  <=これは4桁の数字じゃない。。
#  
#  ちょっと数減った
#      3: 88
#      4: 53
#      5: 47
#      6: 44
#      7: 40
#      8: 30
#

# 多角数を求める
def figurate_number(e, n)
  r = nil
  case e
    when 3
      r = n * (n + 1) / 2
    when 4
      r = n**2
    when 5
      r = n * (3 * n - 1) / 2
    when 6
      r = n * (2 * n - 1)
    when 7
      r = n * (5 * n - 3) / 2
    when 8
      r = n * (3 * n - 2)
  end
  r
end

class Integer
  def u2
    self.to_s[0,2].to_i
  end
  
  def l2
    self.to_s[2,2].to_i
  end
end

# とりあえずテーブルを作ってみる
$ft  = {} # 多角数テーブル

(3..8).each {|e|
  $ft[e] = []

  n = 0
  loop {
    n += 1

    f = figurate_number(e,n)
    #puts "P(#{e},#{n}) = #{f}" if n < 10

    # 4桁の数を対象とする
    next if f < 1000
    break if f >= 10000

    # 10の位が0の数は次が続かないので除外
    if f.to_s[2,1] == "0"
      #puts "remove P(#{e},#{n}) = #{f}" 
      next
    end

    $ft[e] << f
  }
  #puts "#{e}: #{$ft[e].size}"
}

$rv = nil

def choice(path, a)
  #puts "path=#{path.pretty_inspect.chomp}, a=#{a.pretty_inspect}"

  if a.size == 0
    if path[0].u2 == path[-1].l2
      puts "hit!!! path=#{path.pretty_inspect}"
      $rv = path
      throw(:loop)
    end
  end

  a.each{|h|
    #選択したhを抜いた多角数のインデックスを作成
    aa = a.dup
    aa.delete(h)

    # 選択した多角数を総当たり
    $ft[h].each{|f|
      # パスの最後と前半が一致しているかチェック
      if path[-1].l2 == f.u2
        choice(path + [f], aa)
      end
    }
  }
end

#
catch(:loop) {
  $ft[3].each_with_index{|n, i|
    puts "progress... #{i}/#{$ft[3].size}"
    choice([n], [4,5,6,7,8])
  }
}

# 結果の出力
puts "result = #{$rv.sum}"
