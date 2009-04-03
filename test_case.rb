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
end

