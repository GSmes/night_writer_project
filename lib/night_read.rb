require_relative 'night_reader'

class FileReader
  def read
    filename = ARGV[0]
    File.read(filename)
  end

  def write(text)
    filename = ARGV[1]
    File.write(filename, text)
  end
end

class NightWrite
  attr_reader :file_reader

  def initialize
    @file_reader = FileReader.new
  end

  def decode_file_to_english
    braille = file_reader.read
    plain = decode_to_english(braille)
  end

  def decode_to_english(input)
    nr = NightReader.new(input)
    english = file_reader.write(nr.print_output)
  end
end

nw = NightWrite.new
nw.decode_file_to_english

lines = File.readlines(ARGV[1])
text = lines.join.delete("\n")
total_chars = text.length

puts "Created '#{ARGV[1]}' containing #{total_chars} characters."
