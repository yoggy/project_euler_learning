#!/usr/bin/ruby
require 'pe_mylib'
desc "フィボナッチ数列で一番始めに1000桁になる数は何番目？"

# ここ以下にプログラム書く
class Fibonacci
  def initialize
    @count = 0
    @fn   = 1 # 今の値
    @fn_1 = 1 # 1つ前の値
    @fn_2 = 1 # 2つ前の値
  end

  def count
    @count
  end

  def val
    @fn
  end

  def next
    @count += 1
    if @count >= 3
      @fn_2 = @fn_1
      @fn_1 = @fn
      @fn   = @fn_1 + @fn_2
    end
  end

  def succ
    self.next
    val 
  end
end

# 結果の出力
f = Fibonacci.new
loop {
  n = f.succ
  break if n.to_s.size >= 1000
}

puts "result = #{f.count}"
