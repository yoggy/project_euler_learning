#!/usr/bin/ruby
require 'test/unit'
require 'pe_mylib'

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
end

