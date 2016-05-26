require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/night_writer'

class NightWriterTest < Minitest::Test
  attr_reader :test_data

  def setup
    @test_data = File.read("sample_english_spaces.txt")
  end

  def test_that_lowercase_letter_prints_in_braille
    nw = NightWriter.new("a")
    output = "0.\n..\n.."
    assert_equal output, nw.print_output
  end

  def test_hello_world_is_on_three_lines
    nw = NightWriter.new("hello world")
    line1 = "0.0.0.0.0....00.0.0.00"
    line2 = "00.00.0..0..00.0000..0"
    line3 = "....0.0.0....00.0.0..."
    output = "#{line1}\n#{line2}\n#{line3}"
    assert_equal output, nw.print_output
  end

  def test_delete_new_lines_removes_new_line_characters
    nw = NightWriter.new("delete\nnew\nline\nchars\n")
    assert_equal "deletenewlinechars", nw.delete_new_lines
  end

  def test_index_the_capitals_gets_array_of_where_capitals_are
    nw = NightWriter.new("Hello World")
    assert_equal [0,6], nw.index_the_capitals
  end

  def test_star_the_capitals_and_downcase_method
    nw = NightWriter.new("Hello World")
    nw.star_the_capitals_and_downcase
    assert_equal ("*hello *world"), nw.input
  end

  def test_capital_letter_is_put_in_proper_braille
    nw = NightWriter.new("H")
    line1 = "..0."
    line2 = "..00"
    line3 = ".0.."
    output = "#{line1}\n#{line2}\n#{line3}"
    assert_equal output, nw.print_output
  end

  def test_index_the_numbers_indexes_where_pound_should_be
    nw = NightWriter.new("7 79")
    assert_equal [0,2], nw.index_the_numbers
  end

  def test_index_the_numbers_adds_the_pound_sign_only_once
    nw = NightWriter.new("79 7 7 79990 9")
    nw.place_pound_at_numbers
    assert_equal "#79 #7 #7 #79990 #9", nw.input
  end

  def test_pound_sign_added_and_in_proper_braille
    nw = NightWriter.new("7 79")
    line1 = ".000...000.0"
    line2 = ".000...0000."
    line3 = "00....00...."
    output = "#{line1}\n#{line2}\n#{line3}"
    assert_equal output, nw.print_output
  end

  def test_each_line
    nw = NightWriter.new("first line~second line")
    assert_equal ["first line", "second line"], nw.each_line
  end

  def test_arrange_line_arranges_lines_into_an_array
    nw = NightWriter.new("h~h")
    output = ['0.','00','..','0.','00','..']
    assert_equal output, nw.arranged_lines_in_array
  end

  def test_hello_world_top_line_is_in_correct_braille
    nw = NightWriter.new("hello world")
    top = "0.0.0.0.0....00.0.0.00"
    assert_equal top, nw.top("hello world")
  end

  def test_hello_world_middle_line_is_in_correct_braille
    nw = NightWriter.new("hello world")
    middle = "00.00.0..0..00.0000..0"
    assert_equal middle, nw.middle("hello world")
  end

  def test_hello_world_bottom_line_is_in_correct_braille
    nw = NightWriter.new("hello world")
    bottom = "....0.0.0....00.0.0..."
    assert_equal bottom, nw.bottom("hello world")
  end
end
