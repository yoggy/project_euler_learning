#!/usr/bin/ruby
require 'pe_mylib'

# How many hands did player one win in the game of poker?
desc "ポーカーでplayer1が勝つのはいくつあるか？"

# 手札の組を以下のURLからダウンロードして、これを元に勝敗を考える
# http://projecteuler.net/project/poker.txt

# 役の種類。下へ行くほど強い
#   High Card: 何も無し
#   One Pair: 1ペア
#   Two Pairs: 2ペア
#   Three of a Kind: 同じ数で違う種類のカードが3枚
#   Straight: 連続した数が5枚
#   Flush: 5枚のカードが同じ種類
#   Full House: 3カード + 1ペア
#   Four of a Kind: 同じ数で違う種類のカードが4枚
#   Straight Flush: ストレート+フラッシュ
#   Royal Flush: 10, J, Q, K, Aで同じ種類
#
# 数の大きさ
#   2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K, A
#
# 判定方法
#   (1) 役が大きい方が勝ち
#   (2) 同じ役の場合は役を構成するカードの中で一番大きな数
#   (3) それでも決まらない場合は...?
#
# とりあえず順番を決めてみる
#  @@hand_order = {
#    :high_card       => 0,
#    :one_pair        => 1,
#    :two_pair        => 2,
#    :three_of_a_kind => 3,
#    :straight        => 4,
#    :flush           => 5,
#    :full_house      => 6,
#    :four_of_a_kind  => 7,
#    :straight_flush  => 8,
#    :royal_flush     => 9,
#  }

class Card 
  @@suit = [:spade, :dia, :heart, :club]

  attr_reader :num, :suit

  def initialize(str)
    @num  = conv_num(str[0,1])
    @suit = conv_suit(str[1,1])
  end

  def conv_num(s)
    n = 0
    if "2"[0] <= s[0] && s[0] <= "9"[0]
      n = s.to_i
    elsif s == "T"
      n = 10
    elsif s == "J"
      n = 11
    elsif s == "Q"
      n = 12
    elsif s == "K"
      n = 13
    elsif s == "A"
      n = 14
    else
      raise "invalid num str...str=#{s}"
    end
    n
  end

  def rconv_num(n)
    s = ""
    if 2 <= n && n <= 9
      s = n.to_s
    elsif n == 10
      s = "T"
    elsif n == 11
      s = "J"
    elsif n == 12
      s = "Q"
    elsif n == 13
      s = "K"
    elsif 14
      s = "A"
    else
      raise "invalid num range...n=#{n}"
    end
    s
  end

  def conv_suit(s)
    case s
      when "S"
        return :spade
      when "D"
        return :dia
      when "H"
        return :heart
      when "C"
        return :club
      else
        raise "invalid suit string...str=#{s}"
    end
  end

  def rconv_suit(s)
    s.to_s[0,1].upcase
  end

  def >(other)
    @num > other.num
  end

  def >=(other)
    @num >= other.num
  end

  def ==(other)
    @num == other.num
  end

  def <=(other)
    @num <= other.num
  end

  def <(other)
    @num < other.num
  end

  def <=>(other)
    @num <=> other.num
  end

  def to_s
    rconv_num(@num) + rconv_suit(@suit)
  end
end

module Hand
  class Base
    def initialize(cs, order, hand_max)
      @order     = order
      @hand_max  = hand_max
      @other_max = cs.inject(0) {|r, n|
        if n.num == @hand_max
          r
        elsif n.num > r
          n.num
        else
          r
        end
      }
    end

    attr_reader :order, :hand_max, :other_max

    # とりあえず比較演算子はこれだけ実装w
    def >(other)
      # どちらの役が強いか判定
      if @order > other.order
        return true
      elsif @order < other.order
        return false
      end
  
      # 役が同じの場合、役を構成する数の中で一番大きい数で判定
      if @hand_max > other.hand_max
        return true
      elsif @hand_max < other.hand_max
        return false
      end
      
      # それでも同じの場合、役を構成しない数の中で最大を比較？
      if @other_max > other.other_max
        return true
      elsif @other_max < other.other_max
        return false
      end

      raise "not implemented this rule ..."
    end

    def to_s
      "#{self.class.to_s}, @order=#{@order}, @hand_max=#{@hand_max}, @other_max=#{@other_max}"
    end
  end

  class HighCard < Base
    def initialize(cs)
      @order = 0
      @hand_max = cs.inject(0) {|r, c| r >= c.num ? r : c.num}
      @other_max = cs.inject(0) {|r, c| r >= c.num ? r : c.num}
    end
  end

  class OnePair < Base
    def self.create(cs)
      [0,1,2,3,4].combination(2).each{|i,j|
        if cs[i].num == cs[j].num
          return OnePair.new(cs, 1, cs[i].num)
        end
      }
      nil
    end
  end

  class TwoPair < Base
    def self.create(cs)
      pair_num = []

      [0,1,2,3,4].combination(2).each{|i,j|
        if cs[i].num == cs[j].num
          next if pair_num.include?(cs[i].num)
          pair_num << cs[i].num
        end
      }

      if pair_num.size == 2
        max = pair_num.sort[1]
        return TwoPair.new(cs, 2, max)
      end

      nil
    end
  end

  class ThreeOfAKind < Base
    def self.create(cs)
      [0,1,2,3,4].combination(3).each{|i,j,k|
        if cs[i].num == cs[j].num && cs[j].num == cs[k].num
          return ThreeOfAKind.new(cs, 3, cs[i].num)
        end
      }

      nil
    end
  end

  class Straight < Base
    def self.create(cs)
      s = cs.sort
      old_num = nil
      s.each {|c|
        if old_num == nil
          old_num = c.num
        else
          return nil if c.num - 1 != old_num
        end
        old_num = c.num
      }
      Straight.new(cs, 4, s[-1].num)
    end
  end

  class Flush < Base
    def self.create(cs)
      suit = nil
      cs.each {|c|
        if suit == nil
          suit = c.suit
        else
          return nil if suit != c.suit
        end
      }
      Flush.new(cs, 5, cs.inject(0) {|r, n| n.num > r ? n.num : r})
    end
  end

  class FullHouse < Base
    def self.create(cs)
      #3カードの判定
      t = nil
      [0,1,2,3,4].combination(3).each{|i,j,k|
        if cs[i].num == cs[j].num && cs[j].num == cs[k].num
          t = cs[i].num
          break
        end
      }
      return nil if t == nil

      # 3カードの部分を取り除く
      r = cs.inject([]) {|r, c|
        if c.num == t
          r
        else
          r << c
        end 
      }
      if r[0].num == r[1].num
        return FullHouse.new(cs, 6, t)
      end
      nil
    end
  end

  class FourOfAKind < Base
    def self.create(cs)
      [0,1,2,3,4].combination(4).each{|i,j,k,l|
        if cs[i].num == cs[j].num && cs[j].num == cs[k].num && cs[k].num == cs[l].num
          return FourOfAKind.new(cs, 7, cs[i].num)
        end
      }
      nil
    end
  end

  class StraightFlush < Base
    def self.create(cs)
      h_flush = Flush.create(cs)
      return nil if h_flush == nil
      h_straight = Straight.create(cs)
      return nil if h_straight == nil

      StraightFlush.new(cs, 8, h_straight.hand_max)
    end
  end

  class RoyalFlush < Base
    def self.create(cs)
      h_straight = Straight.create(cs)
      return nil if h_straight == nil
      return nil if h_straight.hand_max != 14 #Aが最後じゃないとRoyalFlushではない

      h_flush = Flush.create(cs)
      return nil if h_flush == nil

      RoyalFlush.new(cs, 8, h_straight.hand_max)
    end
  end

  # 役クラスを作成するファクトリメソッド
  def create(cs)
    # 順に評価して、ヒットしたものを採用
    create_proc = [
      Proc.new {|cs| RoyalFlush.create(cs)},
      Proc.new {|cs| StraightFlush.create(cs)},
      Proc.new {|cs| FourOfAKind.create(cs)},
      Proc.new {|cs| FullHouse.create(cs)},
      Proc.new {|cs| Flush.create(cs)},
      Proc.new {|cs| Straight.create(cs)},
      Proc.new {|cs| ThreeOfAKind.create(cs)},
      Proc.new {|cs| TwoPair.create(cs)},
      Proc.new {|cs| OnePair.create(cs)},
      Proc.new {|cs| HighCard.new(cs)},
    ]

    create_proc.inject(nil) {|r, n| r == nil ? n.call(cs) : r}
  end

  module_function :create
end

class Cards
  def initialize(cards)
    @c = []
    cards.each{|str|
      @c << Card.new(str)
    }
    @hand = Hand.create(@c)
  end
  attr_reader :c, :hand

  def to_s
    "[" + @c.join(",") + "](#{@hand.to_s})"
  end
end


#
# for test...
#
#%w[2 3 4 5 6 7 8 9 T J Q K A].each {|n|
#  %w[S H D C].each {|s|
#    pp Card.new(n+s).to_s
#  }
#}
#
#puts Cards.new(%w[4H 2C AS 7S QD]).to_s #hight card
#puts Cards.new(%w[5H 5C 6S 7S KD]).to_s #one pair
#puts Cards.new(%w[5H 5C 6S 7S 6D]).to_s #two pair
#puts Cards.new(%w[5H 5C 5S 7S 6D]).to_s #three of a kind
#puts Cards.new(%w[TH 7C 6S 9S 8D]).to_s #straight
#puts Cards.new(%w[3H 7H 6H 9H 8H]).to_s #flush
#puts Cards.new(%w[4H 4S 4D AD AD]).to_s #full house
#puts Cards.new(%w[5H 5C 5S 5D 6D]).to_s #four of a kind
#puts Cards.new(%w[7H 9H 8H JH TH]).to_s #straight flush
#puts Cards.new(%w[AH QH JH KH TH]).to_s #royal flush
#
#__END__

#
# main
#
url = "http://projecteuler.net/project/poker.txt"
text = read_from(url)

count = 0
text.each_line{|l|
  l.chomp!
  a = l.split(" ")
  p1 = Cards.new(a[0,5])
  p2 = Cards.new(a[5,5])

  if p1.hand > p2.hand
    count += 1
  end
}

# 結果の出力
puts "result = #{count}"
