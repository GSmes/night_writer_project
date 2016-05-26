require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/braille_map'

class BrailleMapTest < Minitest::Test

  def test_braille_converts_a_to_correct_braille
    bm = BrailleMap.new
    braille = bm.lowercase
    assert_equal ["0",".",".",".",".","."], braille["a"]
    assert_equal ["0",".","0",".",".","."], braille["b"]
    assert_equal ["0",".",".","0","0","0"], braille["z"]
    assert_equal 26, braille.count
  end

  def test_that_space_is_added_to_map
    bm = BrailleMap.new
    braille = bm.space
    assert_equal [".",".",".",".",".","."], braille[" "]
    assert_equal 1, braille.count
  end

  def test_that_capital_is_added
    bm = BrailleMap.new
    braille = bm.capital
    assert_equal [".",".",".",".",".","0"], braille["*"]
    assert_equal 1, braille.count
  end

  def test_that_special_is_added
    bm = BrailleMap.new
    braille = bm.special
    assert_equal [".",".","0","0","0","."], braille['!']
    assert_equal 6, braille.count
  end

  def test_that_braille_map_is_created
    bm = BrailleMap.new
    braille = bm.braille_map
    assert_equal 45, braille.count
  end

  def test_letters_or_numbers_is_a_braille_object
    bm = BrailleMap.new
    object = bm.letters_or_numbers
    assert_equal 10, object.count
  end
end
