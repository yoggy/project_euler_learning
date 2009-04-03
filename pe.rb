#!/usr/bin/ruby
#
# Project EulerをRubyで解く際に個人的に使う関数とか
#
# 使い方
#   ./pe.rb generate 問題番号
#
#
#

# 問題で使いそうなパッケージを書いておく
require 'mathn'
require 'pp'

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
    data = File.read(__FILE__).split(RE_THIS_DATA.call(num))
    data[1].split(RE_THE_DATA)[0] if data[1]
  end
end

#
# 以下サブコマンドの処理
#
def pe_subcommand_generate(num_str)
  n = num_str.to_i
  filename = sprintf("p%03d.rb", n)

  if File.exist? filename
    STDERR.puts "#{filename} already exists..."
    exit 0
  end

  open(filename, "w") {|f|
   f.write __data__
   f.flush
  }

  File.chmod(0100755, filename)
  STDERR.puts "generate #{filename} for problem #{n}..."
  
end

def pe_subcommand_help
  STDERR.puts <<-EOS_HELP
usage : #{File.basename($0)} command arg0 arg1 ...
    help     : show this message
    generate : generate template file
               usage :  #{File.basename($0)} problem_number
  EOS_HELP
  exit 0
end

#
# コマンドラインから起動したときのメイン
#
if __FILE__ == $0
  if ARGV.size == 0
    pe_subcommand_help
  end

  # サブコマンド解析＆実行
  cmd = ARGV[0].downcase
  case cmd
    when 'generate'
      pe_subcommand_generate ARGV[1]
    when 'help' || '-h' || '--help'
      pe_subcommand_help
    else
      pe_subcommand_help
  end
end

#
# 以下、問題を解くときに使いそうな機能
#

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
  pp self
  unless self.methods.include?("divisor")
    def divisor
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
  end
end
__END__
__DATA__
#!/usr/bin/ruby
require 'pe'
desc "ここに問題文を書く"

# ここ以下にプログラム書く
a = 1 + 2 + 3


# 結果の出力
rv = "not implemented..."
puts "result = #{rv}"
