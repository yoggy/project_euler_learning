#!/usr/bin/ruby
require 'test/unit'
require 'pe_mylib'
require 'prime_table'

class MyTestCase < Test::Unit::TestCase
  def test_divisors
    assert_equal([1],            1.divisors)
    assert_equal([1,2],          2.divisors)
    assert_equal([1,2,4],        4.divisors)
    assert_equal([1,2,3,6],      6.divisors)
    assert_equal([1,2,3,4,6,12], 12.divisors)
  end

  def test_proper_divisors
    assert_equal([1],          2.proper_divisors)
    assert_equal([1,2],        4.proper_divisors)
    assert_equal([1,2,3],      6.proper_divisors)
    assert_equal([1,2,3,4,6], 12.proper_divisors)
  end
  
  def test_cache_calc
    rv = (1..100).inject([]) {|r, n| r << n ** n}
    rv_nocache = cache_calc("test", false) {
      rv
    }
    rv_cache = cache_calc("test") {
      rv + rv + rv
      rv + rv
      rv
    }
    assert_equal(rv, rv_nocache)
    assert_equal(rv, rv_nocache)
  end

  def test_prime?
    assert_equal(true,  2.prime?)
    assert_equal(true,  3.prime?)
    assert_equal(false, 4.prime?)
    assert_equal(true,  5.prime?)
    assert_equal(false, 10.prime?)
    assert_equal(true, 97.prime?)
  end

  def test_sum
    assert_equal(1+2+3+4+5, [1,2,3,4,5].sum)
    assert_equal(1+2+3+4+5+6+7+8+9+10, [1,2,3,4,5,6,7,8,9,10].sum)
  end

  def test_multi
    assert_equal(1*2*3*4*5, [1,2,3,4,5].mult)
    assert_equal(1*2*3*4*5*6*7*8*9*10, [1,2,3,4,5,6,7,8,9,10].mult)
  end

  def test_each_digit
    n = 12345
    total = 0
    n.each_digit {|d|
      total += d
    }
    assert_equal(1+2+3+4+5, total)
  end
 
  def test_each_char
    src = "12345"
    dst = ""
    src.each_char{|c|
      dst += c
    }
    assert_equal(src, dst)
  end

  def test_choice_and_call
    src = [1,2,3]
    dst = []
    src.choice_and_call {|a|
      dst << a
    }
    assert_equal([[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]], dst)
  end

  def test_fact
    assert_equal(1, 1.fact)
    assert_equal(6, 3.fact)
    assert_equal(3628800, 10.fact)
  end

  def test_prime_table
    p = Prime.new
    100.times{
      p.succ
    }
    assert_equal(547, p.succ)

    1234.times{
      p.succ
    }
    assert_equal(11003, p.succ)
  end

  def test_digit
    n = 1
    assert_equal(1, n.digit)
    n = 23
    assert_equal(2, n.digit)
    n = 345
    assert_equal(3, n.digit)
    n = 9999
    assert_equal(4, n.digit)
  end

  def test_integer_to_a
    assert_equal([1,2,3,4,5,6,7,8,9], 123456789.to_a)
  end
end

