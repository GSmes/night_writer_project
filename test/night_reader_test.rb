require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/night_reader"

class NightReaderTest < MiniTest::Test
  attr_reader :hEllo_World7_79, :test

  def setup
    @hEllo_World7_79 = "0...0.0.0.0......00.0.0.00.000...000.0..\n00...00.0..0....00.0000..0.000...0000...\n...0..0.0.0....0.00.0.0...00....00......\n"
    @test = File.read("sample_braille_spaces.txt")
  end

  def test_that_split_input_splits_on_new_line
    #input is 'h'
    nr = NightReader.new("0.\n00\n..")
    assert_equal ["0.","00",".."], nr.split_input
  end

  def test_get_line_gets_line1_line2_and_line3
    nr = NightReader.new("0.\n00\n..")
    assert_equal "0.", nr.line1
    assert_equal "00", nr.line2
    assert_equal "..", nr.line3
  end

  def test_braille_letters_breaks_lines_into_characters_and_adds_to_array
    nr = NightReader.new("0.\n00\n..")
    assert_equal ["0.00.."], nr.braille_letters
  end

  def test_english_without_nums_converts_one_braille_letter_to_english
    nr = NightReader.new("0.\n00\n..")
    assert_equal "h", nr.english_without_nums.join
  end

  def test_english_without_nums_converts_a_whole_string_without_numbers
    nr = NightReader.new(hEllo_World7_79)
    assert_equal "h*ello *world#g #gi ", nr.english_without_nums.join
  end

  def test_index_the_numbers_returns_indexes_of_where_numbers_should_be
    nr = NightReader.new(hEllo_World7_79)
    assert_equal [13, 14, 16, 17, 18], nr.index_the_numbers
  end

  def test_sub_in_numbers_replaces_letter_with_correct_number
    nr = NightReader.new(hEllo_World7_79)
    assert_equal "h*ello *world#7 #79 ", nr.sub_in_num.join
  end

  def test_index_the_capitals_gets_indexes_of_where_the_capital_letters_are
      nr = NightReader.new(hEllo_World7_79)
      assert_equal [1,7], nr.index_the_capitals
  end

  def test_capitalize_where_capitals_are_indexed
    nr = NightReader.new(hEllo_World7_79)
    assert_equal "h*Ello *World#7 #79 ", nr.capitalize_the_indexed
  end

  def test_remove_special_char_tags_removes_stars_and_pound
    nr = NightReader.new(hEllo_World7_79)
    assert_equal "hEllo World7 79 ", nr.remove_special_char_tags
  end

  def test_index_the_spaces_marks_the_spaces
    nr = NightReader.new(hEllo_World7_79)
    assert_equal [5, 12, 15], nr.index_the_spaces
  end

  def test_index_the_spaces_marks_the_spaces_with_sample
    nr = NightReader.new(test)
    output = [9, 19, 29, 39, 49, 59, 69, 79, 89, 99]
    assert_equal output, nr.index_the_spaces
  end

  def test_put_in_new_lines_with_sample_data
    nr = NightReader.new(test)
    output = "abcdefghi jklmnopqr stuvwxyza abcdefghi jklmnopqr stuvwxyza abcdefghi jklmnopqr \nstuvwxyza abcdefghi "
    assert_equal output, nr.put_in_new_lines
  end
end
