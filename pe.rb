#!/usr/bin/ruby
#
# Project EulerをRubyで解く際に個人的に使う関数とか
#
# 使い方
#   ./pe.rb generate 問題番号
#
#
#
require 'pe_mylib.rb'

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
