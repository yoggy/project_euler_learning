#!/usr/bin/ruby
require 'pp'
require 'mathn'

$prime_table_cache_file = ".prime_table_01"

unless File.exists?($prime_table_cache_file)
  system("wget http://primes.utm.edu/lists/small/millions/primes1.zip") unless File.exists?("primes1.zip")
  system("unzip primes1.zip")  unless File.exists?("primes1.txt")
  system("nkf -Lu --overwrite primes1.txt")

  count = 4
  fw = open($prime_table_cache_file, "w")
  open("primes1.txt","r") {|f|
    while l = f.gets
      #先頭4行は読み飛ばし
      unless count == 0
        count -= 1
        next
      end

      a = l.strip.split

      next if a.size == 0
      a.each{|s|
        fw.puts s
      }
    end
  }
  fw.close
end

$__prime_table = []
$__prime_hash = {}

open($prime_table_cache_file, "r") {|f|
  while str = f.gets
    p = str.to_i
    $__prime_table << p
    $__prime_hash[p] = true
  end
}

class Prime
  def initialize
    @pos = -1
  end

  def succ
    @pos += 1
    $__prime_table[@pos]
  end
end

class Integer
  def prime?
    $__prime_hash.key?(self)
  end
end
