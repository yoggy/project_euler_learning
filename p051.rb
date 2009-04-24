#!/usr/bin/ruby
require 'pe_mylib'
# Find the smallest prime which, by changing the same part of the number, can form eight different primes.
desc "素数の同じ部分を同じ数で置き換える事によって8つの素数を生成できる最小の数は何？"

# 問題では例として3桁の157, 257, 457, 557, 757, 857と
# 5桁の56003, 56113, 56333, 56443, 56663, 56773, 56993が示されている

# 考えるポイント
#   列挙
#     素数の列挙
#     同じ数による置き換え
#       11とか22とかの部分。ただしこの数は桁が連続していなくても良い
#       基本的に小さいもの順から
#
#   効率?
#     8つの素数が生成可能な数ということは、答えの数で置換可能な数字は
#     0, 1, 2のいずれか。置き換えパターンとしては、
#
#       0,1,2,3,4,5,6,7 <- このケースは先頭の桁ではない部分
#       0,1,2,3,4,5,6,8
#             ・
#             ・
#       1,2,3,4,5,6,7,8
#       1,2,3,4,5,6,7,9
#             ・
#             ・
#       2,3,4,5,6,7,8,9
#
#       という感じで置き換えするはずだから。3以上の部分は置き換え対象にならない
#       なぜなら既に過去に調べられたパターンのはずだから...
#
#      考え中の手順
#        (1) 素数取り出し(p)
#        (2) その数に0,1,2が含まれているか？(d0,d1,d2)
#        (3) d0,d1,d2を含んでいた場合は、その部分をdn<nで置き換えていく
#            * nで置き換え
#            * 素数かどうか判定
#            * 素数じゃなければパス、素数だった倍はcount++してnをすすめる
#        (4) count == 8だった場合は、その数が答え
#
#   探索範囲
#     8個の素数が生成可能な素数が登場するまで
#

# ここ以下にプログラム書く


# 結果の出力
rv = "not implemented..."
puts "result = #{rv}"
