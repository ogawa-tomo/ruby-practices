#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('l', 'c', 'w')
  output_data = get_output_data(options)
  if !ARGV.empty?
    files_data = get_files_data(ARGV)
    output_files_info(files_data, output_data)
  else
    content = $stdin.read
    output_stdin_info(content, output_data)
  end
end

def get_output_data(options)
  {
    line_count: output_line_count?(options),
    word_count: output_word_count?(options),
    byte_size: output_byte_size?(options)
  }
end

def output_line_count?(options)
  !options['l'] && !options['w'] && !options['c'] ? true : options['l']
end

def output_word_count?(options)
  !options['l'] && !options['w'] && !options['c'] ? true : options['w']
end

def output_byte_size?(options)
  !options['l'] && !options['w'] && !options['c'] ? true : options['c']
end

def get_files_data(files_path)
  files_path.map do |file_path|
    content = nil
    File.open(file_path) do |file|
      content = file.read
    end
    {
      name: file_path,
      content:
    }
  end
end

def output_files_info(files_data, output_data)
  line_count_digit = get_total_line_count(files_data).to_s.length
  word_count_digit = get_total_word_count(files_data).to_s.length
  byte_size_digit = get_total_byte_size(files_data).to_s.length

  files_data.each do |file_data|
    print ' '
    print_data(file_data[:content].lines.length.to_s.rjust(line_count_digit), output_data[:line_count])
    print_data(file_data[:content].split.length.to_s.rjust(word_count_digit), output_data[:word_count])
    print_data(file_data[:content].bytesize.to_s.rjust(byte_size_digit), output_data[:byte_size])
    print file_data[:name]
    puts ''
  end

  return unless files_data.length > 1

  print ' '
  print_data(get_total_line_count(files_data).to_s.rjust(line_count_digit), output_data[:line_count])
  print_data(get_total_word_count(files_data).to_s.rjust(word_count_digit), output_data[:word_count])
  print_data(get_total_byte_size(files_data).to_s.rjust(byte_size_digit), output_data[:byte_size])
  puts 'total'
end

def print_data(data, output)
  print "#{data} " if output
end

def get_total_line_count(files_data)
  files_data.map { |file_data| file_data[:content].lines.length }.sum
end

def get_total_word_count(files_data)
  files_data.map { |file_data| file_data[:content].split.length }.sum
end

def get_total_byte_size(files_data)
  files_data.map { |file_data| file_data[:content].bytesize }.sum
end

def output_stdin_info(content, output_data)
  output_data_num = output_data.count { |k, v| v }

  print_stdin_data(content.lines.length, output_data_num) if output_data[:line_count]
  print_stdin_data(content.split.length, output_data_num) if output_data[:word_count]
  print_stdin_data(content.bytesize, output_data_num) if output_data[:byte_size]
end

def print_stdin_data(data, output_data_num)
  if output_data_num == 1
    print data
  else
    print("#{data.to_s.rjust(7)} ")
  end
end

main
