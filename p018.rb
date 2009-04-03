#!/usr/bin/ruby
require 'pe_mylib'
desc "次の三角形で最大になるルートの合計は？"

$str = <<-EOS
              75
             95 64
            17 47 82
           18 35 87 10
          20 04 82 47 65
         19 01 23 75 03 34
        88 02 77 73 07 63 67
       99 65 04 28 06 16 70 92
      41 41 26 56 83 40 80 70 33
     41 48 72 33 47 32 37 16 94 29
    53 71 44 65 25 43 91 52 97 51 14
   70 11 33 28 77 73 17 78 39 68 17 57
  91 71 52 38 17 14 91 43 58 50 27 29 48
 63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
EOS

class Tree
  def initialize
    # Treeというクラス名だけど、内部では2次元配列でツリーを作成するｗ
    @tree = []
    $str.each{|l|
      @tree << l.split.map{|s| s.to_i}
    }
  end

  def width(y)
    @tree[y].size
  end
  
  def height
    @tree.size
  end

  def get(x, y)
    @tree[y][x]
  end

  # (x,y)の位置から下に[0,1,0,1,....]と辿った数の合計を求める
  # 0は左下、1は右下へ辿る意味
  def traverse(x, y, a)
    return get(x, y) if a == nil || a.size == 0
    get(x, y) + traverse(x + a[0], y + 1, a[1..-1])
  end
  
  # パスIDに対応する合計を返す
  def sum(i)
    b = i.to_s(2)                        # 10->2進数変換
    b = "0" * (height - 1 - b.size) + b  # 先頭を0埋めする
    a = b.split(/ */).map{|s| s.to_i}    # 文字列->配列
    traverse(0, 0, a)
  end

  def comb_num
    2 ** (height-1)
  end

  def max_sum
    # とりあえずいい方法が思いつかないので、総当たりでw
    (0...comb_num).inject(-1) {|m, i|
      s = sum(i)
      s > m ? s : m
    }
  end
end

# 結果の出力
t = Tree.new
puts "result = #{t.max_sum}"

