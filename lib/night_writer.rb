require 'pry'
require_relative 'braille_map'

class NightWriter
  attr_reader :input, :braille_map

  def initialize(input)
    @input = input
    @braille_map = BrailleMap.new.braille_map
  end

  def print_output
    finalized_input_string
    output = ''
    arranged_lines_in_array.each do |line|
       output += line + "\n"
    end
    output = output.chomp
    "#{output}"
  end

  def finalized_input_string
    delete_new_lines
    star_the_capitals_and_downcase
    place_pound_at_numbers
  end

  def delete_new_lines
    input.gsub!("\n","")
  end

#star_the_capitals_and_downcase

  def star_the_capitals_and_downcase
    index_the_capitals.reverse.each do |index|
      input[index] = input[index].downcase
      input.insert(index, "*")
    end
  end

  def index_the_capitals
    input.chars.map.with_index do |char, index|
      index if ("A".."Z").include?(char)
    end.compact
  end

#place_pound_at_numbers

  def place_pound_at_numbers
    index_the_numbers.reverse.each do |index|
      input.insert(index, "#")
    end
  end

  def index_the_numbers
    input.chars.map.with_index do |char, index|
      if valid_number?(char)
        index if index == 0 || no_number_before?(index)
      end
    end.compact
  end

  def valid_number?(character)
    character.to_i.to_s == character.to_s
  end

  def no_number_before?(index)
    previous_character = input[index - 1]
    valid_number?(previous_character) == false
  end

#prepare_lines_to_be_output

  def arranged_lines_in_array
    each_line.map do |line|
      [top(line), middle(line), bottom(line)]
    end.flatten
  end

  def each_line
    input.split("~")
  end

  def top(line)
    arrange_line(line, 0..1)
  end

  def middle(line)
    arrange_line(line, 2..3)
  end

  def bottom(line)
    arrange_line(line, 4..5)
  end

  def arrange_line(line, level)
    line.chars.map do |letter|
      braille_map[letter][level]
    end.join
  end
end
