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
 
  def proper_divisors
    d = divisors 
    d.pop if d.size > 1 
    d 
  end 

  def proper_divisors_sum
    proper_divisors.inject {|r,n| r + n}
  end 

  def prime?
    v = self.prime_division
    return true if v.size == 1 && v[0][1] == 1
    false
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

