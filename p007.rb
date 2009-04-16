#!/usr/bin/ruby
require 'pe_mylib'
desc "10001番目の素数は何？"

require 'prime_table'

# mathnモジュールのPrimeクラスを使うと楽勝w
require 'mathn'
p = Prime.new
10000.times{p.succ}
puts "10001th prime is #{p.succ}"

