#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('l', 'c', 'w')
  if !ARGV.empty?
    files_data = get_files_data(ARGV)
    output_files_info(files_data, options)
  else
    content = $stdin.read
    output_stdin_info(content, options)
  end
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

def output_files_info(files_data, options)
  line_count_digit = get_total_line_count(files_data).to_s.length
  word_count_digit = get_total_word_count(files_data).to_s.length
  byte_size_digit = get_total_byte_size(files_data).to_s.length

  files_data.each do |file_data|
    print ' '
    print_file_data(file_data[:content].lines.length.to_s.rjust(line_count_digit), output_line_count?(options))
    print_file_data(file_data[:content].split.length.to_s.rjust(word_count_digit), output_word_count?(options))
    print_file_data(file_data[:content].bytesize.to_s.rjust(byte_size_digit), output_byte_size?(options))
    print file_data[:name]
    puts ''
  end

  return unless files_data.length > 1

  print ' '
  print_file_data(get_total_line_count(files_data).to_s.rjust(line_count_digit), output_line_count?(options))
  print_file_data(get_total_word_count(files_data).to_s.rjust(word_count_digit), output_word_count?(options))
  print_file_data(get_total_byte_size(files_data).to_s.rjust(byte_size_digit), output_byte_size?(options))
  puts 'total'
end

def print_file_data(data, output)
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

def output_stdin_info(content, options)
  output_data_num = [
    output_line_count?(options),
    output_word_count?(options),
    output_byte_size?(options)
  ].count { |x| x }

  print_stdin_data(content.lines.length, output_data_num) if output_line_count?(options)
  print_stdin_data(content.split.length, output_data_num) if output_word_count?(options)
  print_stdin_data(content.bytesize, output_data_num) if output_byte_size?(options)
end

def print_stdin_data(data, output_data_num)
  if output_data_num == 1
    print data
  else
    print "#{data.to_s.rjust(7)} "
  end
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

main
