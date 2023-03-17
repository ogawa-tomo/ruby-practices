#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  options = ARGV.getopts('l', 'c', 'w')
  output_data = get_output_data(options)
  if !ARGV.empty?
    files_data = get_files_data(ARGV)
    digit_data = get_digit_data(files_data)
    output_each_files_info(files_data, output_data, digit_data)
    return unless files_data.length > 1

    output_total_files_info(files_data, output_data, digit_data)
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

def get_digit_data(files_data)
  {
    line_count_digit: get_total_line_count(files_data).to_s.length,
    word_count_digit: get_total_word_count(files_data).to_s.length,
    byte_size_digit: get_total_byte_size(files_data).to_s.length
  }
end

def output_each_files_info(files_data, output_data, digit_data)
  files_data.each do |file_data|
    print first_blank(files_data, output_data, digit_data)
    print "#{file_data[:content].lines.length.to_s.rjust(digit_data[:line_count_digit])} " if output_data[:line_count]
    print "#{file_data[:content].split.length.to_s.rjust(digit_data[:word_count_digit])} " if output_data[:word_count]
    print "#{file_data[:content].bytesize.to_s.rjust(digit_data[:byte_size_digit])} " if output_data[:byte_size]
    print file_data[:name]
    puts ''
  end
end

def output_total_files_info(files_data, output_data, digit_data)
  print first_blank(files_data, output_data, digit_data)
  print "#{get_total_line_count(files_data).to_s.rjust(digit_data[:line_count_digit])} " if output_data[:line_count]
  print "#{get_total_word_count(files_data).to_s.rjust(digit_data[:word_count_digit])} " if output_data[:word_count]
  print "#{get_total_byte_size(files_data).to_s.rjust(digit_data[:byte_size_digit])} " if output_data[:byte_size]
  puts 'total'
end

def first_blank(files_data, output_data, digit_data)

  first_digit = if output_data[:line_count]
                  digit_data[:line_count_digit]
                elsif output_data[:word_count]
                  digit_data[:word_count_digit]
                elsif output_data[:byte_size_digit]
                  digit_data[:byte_size_digit]
                end


  output_data_num = output_data.count { |k, v| v }

  # 引数ファイルが1つ
  if files_data.length ==1
    # オプションがなしor3つ
    if output_data_num == 3
      if first_digit == 1
        ' '
      elsif first_digit == 2
        ' '
      elsif first_digit == 3
        ' '
      else
        ' '
      end
    # オプションが1つ
    elsif output_data_num == 1
      if first_digit == 1
      elsif first_digit == 2
      elsif first_digit == 3
      else
      end
    # オプションが2つ
    else
      if first_digit == 1
        ' '
      elsif first_digit == 2
        ' '
      elsif first_digit == 3
        ' '
      else
        ' '
      end
    end
  # 引数ファイルが2つ以上
  else
    # オプションがなしor3つ
    if output_data_num == 3
      if first_digit == 1
        ' '
      elsif first_digit == 2
        ' '
      elsif first_digit == 3
        ' '
      else
        ' '
      end
    # オプションが1つ
    elsif output_data_num == 1
      if first_digit == 1
        ' '
      elsif first_digit == 2
        ' '
      elsif first_digit == 3
        ' '
      else
        ' '
      end
    # オプションが2つ
    else
      if first_digit == 1
        ' '
      elsif first_digit == 2
        ' '
      elsif first_digit == 3
        ' '
      else
        ' '
      end
    end
  end

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
  print content.lines.length.to_s.rjust(7) if output_data[:line_count]
  print content.split.length.to_s.rjust(8) if output_data[:word_count]
  print content.bytesize.to_s.rjust(8) if output_data[:byte_size]
end

main
