# 問題で使いそうなパッケージを書いておく
require 'mathn'
require 'pp'
require 'yaml'
require 'yaml/store'
require 'proc_source'

include Math

# 以下、問題を解くときに使いそうな機能とか
 
# Project Eulerの問題とURLを表示する関数。問題数はプログラム名"p問題数3桁.rb"から取得する
def desc(str) 
  problem_base_url = 'http://projecteuler.net/index.php?section=problems&id='
  japanese_base_url = 'http://odz.sakura.ne.jp/projecteuler/index.php?Problem%20'

  problem_num = File.basename($0).scan(/[0-9]+/)[0].to_i

  puts "problem #{problem_num}: #{str}"
  puts "\turl: #{problem_base_url}#{problem_num}"
  puts "\t日本語翻訳: #{japanese_base_url}#{problem_num}"
end

# see also...
# http://www.vidul.com/articles/2008/08/22/ruby-__data__-embedded-data
module Kernel
  RE_THIS_DATA = lambda{ |number| /^__DATA#{number}__\n/ }
  RE_THE_DATA  = /^__DATA\d+__/

  def __data__(num="")
    data = File.read($0).split(RE_THIS_DATA.call(num))
    data[1].split(RE_THE_DATA)[0] if data[1]
  end
end

# from [ruby-list:42671] 
# http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/42671 
class Array 
  unless self.methods.include?("combination") 
    def combination(num) 
      return [] if num < 1 || num > size 
      return map{|e| [e] } if num == 1 
      tmp = self.dup 
      self[0, size - (num - 1)].inject([]) do |ret, e| 
        tmp.shift 
        ret += tmp.combination(num - 1).map{|a| a.unshift(e) } 
      end 
    end 
  end 
  
  unless self.methods.include?("product") 
    def product(other) 
      inject([]) do |ret, es| 
        ret += other.map{|eo| [es, eo]} 
      end 
    end 
  end 
end 
 
# 適当に拡張 
class Integer 
  # 約数を求める 
  def divisors 
    return [1] if self == 1 
    p = self.prime_division 
    p2 = p.map{|v| 
      a = [] 
      (0..v[1]).each {|i| 
        a << v[0] ** i   
      } 
      a 
    }  
    return p2.flatten if p2.size == 1 
    p3 = p2.inject{|r, v| r.product(v)}.map{|v| v.flatten} 
    p3.map{|v| v.inject{|r,v|r*v}}.sort 
  end 
 
  # 自身を除いた約数を求める
  def proper_divisors
    d = divisors 
    d.pop if d.size > 1 
    d 
  end 

  # 自身を除いた約数の和
  def proper_divisors_sum
    proper_divisors.inject {|r,n| r + n}
  end 

  # 素数かどうかの判定
  def prime?
    v = self.prime_division
    return true if v.size == 1 && v[0][1] == 1
    false
  end

  # 各桁を分解してarrayに変換する
  def to_a
    a = []
    self.to_s.each_byte{|b|
      d = b - '0'[0]
      a << d
    }
    a
  end

  # 各桁の数字をeachする
  def each_digit(&block)
    self.to_a.each {|d|
      yield d
    }
  end

  # 桁数を求める
  def digit
    log10(self).to_i + 1
  end

  def fact
    a = 1
    (1..self).each{|i|
      a *= i
    }
    a
  end
end 

class String
  def each_char(&block)
    self.each_byte {|b|
      c = b.chr()
      yield c
    }
  end
end

class Array
  def sum
    self.inject {|r, n|
      r + n
    }
  end

  def mult
    self.inject {|r, n|
      r * n
    }
  end

  # pathは選んだパス、lenはあといくつ選ぶか？、blockはlen=0の時に実行するブロック
  protected
  def _choice_and_call(path, len, &block)
    if len == 0
      block.call(path)
      return
    end

    self.each_with_index{|v, i|
      a = self.dup
      a.delete_at(i)
      a._choice_and_call(path + [v], len - 1, &block)
    }
  end

  # 順番ありの組み合わせ＆ブロック実行するメソッド
  public
  def choice_and_call(len=self.size, &block)
    _choice_and_call([], len, &block)
  end
end

# キャッシュがあればそこから値を取り出し、
# なければ渡されたブロックを評価しキャッシュに格納する
def cache_calc(key, use_cache=true, &block)
  cache_file = ".cache." + key

  # デバッグ用
  File.unlink(cache_file) if !use_cache && File.exists?(cache_file)

  # キャッシュから前に実行したときのブロックのソースコードを取り出し
  db = YAML::Store.new(cache_file)
  src = ""
  db.transaction {
    src = db['source']
  }

  # 空白を詰めて入力ブロックのソースコードを簡単に正規化(?)する
  pseudo_normalize_source = ""
  block.source.each{|l|
    l.strip!
    l.gsub!(/[\t]+/, " ")
    l.gsub!(/[\s]+/, " ")
    next if l =~ /^\s*$/
    pseudo_normalize_source += l + "\n"
  }
  pseudo_normalize_source.gsub(/^;+(.*)$/,"").gsub(/^(.*);+$/,"")

  # 渡されたブロックとキャッシュのブロックを比較。異なった場合はブロックを評価
  if src != pseudo_normalize_source
    rv = yield
    db.transaction {
      db['result'] = rv
      db['source'] = pseudo_normalize_source
    }
  end

  # キャッシュから値取り出し
  rv = nil
  db = YAML::Store.new(cache_file)
  db.transaction {
    rv = db['result']
  }
  rv
end

# ファイルを指定されたURLから取ってくる関数
# 2回目以降はキャッシュを使用する
def read_from(url)
  filename = File.basename(url)

  unless File.exist?(filename)
    system("wget -O#{filename} #{url}")
  end

  text = ""
  open(filename, 'r') {|f|
    text = f.read
  }
  text
end

