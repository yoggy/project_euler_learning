#!/usr/bin/ruby
require 'pe_mylib'
desc "600851475143を素因数分解した素数のうち、いちばん大きな数は？"

# mathnモジュールのInteger.prime_divisionを使って素因数分解する
require 'mathn'

a = 600851475143.prime_division
puts "result = #{a.reverse[0][0]}"
