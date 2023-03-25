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
  digit = [
    get_total_line_count(files_data).to_s.length,
    get_total_word_count(files_data).to_s.length,
    get_total_byte_size(files_data).to_s.length
  ].max

  files_data.each do |file_data|
    print "#{file_data[:content].lines.length.to_s.rjust(digit)} " if output_line_count?(options)
    print "#{file_data[:content].split.length.to_s.rjust(digit)} " if output_word_count?(options)
    print "#{file_data[:content].bytesize.to_s.rjust(digit)} " if output_byte_size?(options)
    print file_data[:name]
    puts ''
  end

  return unless files_data.length > 1

  print "#{get_total_line_count(files_data).to_s.rjust(digit)} " if output_line_count?(options)
  print "#{get_total_word_count(files_data).to_s.rjust(digit)} " if output_word_count?(options)
  print "#{get_total_byte_size(files_data).to_s.rjust(digit)} " if output_byte_size?(options)
  puts 'total'
end

def get_total_line_count(files_data)
  files_data.sum { |file_data| file_data[:content].lines.length }
end

def get_total_word_count(files_data)
  files_data.sum { |file_data| file_data[:content].split.length }
end

def get_total_byte_size(files_data)
  files_data.sum { |file_data| file_data[:content].bytesize }
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
  no_options?(options) ? true : options['l']
end

def output_word_count?(options)
  no_options?(options) ? true : options['w']
end

def output_byte_size?(options)
  no_options?(options) ? true : options['c']
end

def no_options?(options)
  !options['l'] && !options['w'] && !options['c']
end

main
