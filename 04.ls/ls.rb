#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

COLUMN_NUM = 3

def main
  opt = OptionParser.new
  params = {}
  opt.on('-l') { |v| params[:l] = v }
  opt.parse!(ARGV)

  files = Dir.glob('*')
  params[:l] ? output_long(files) : output_default(files)
end

def output_long(files)
  max_word_count_file_owner = files.map { |file| Etc.getpwuid(File.stat(file).uid).name.size }.max
  max_word_count_file_group = files.map { |file| Etc.getgrgid(File.stat(file).gid).name.size }.max
  max_digit_file_size = files.map { |file| File.stat(file).size }.max.to_s.length

  puts "total #{files.map { |file| File.stat(file).blksize }.sum / 1024}"
  files.each do |file|
    stat = File.stat(file)
    stat.ftype == 'file' ? print('-') : print(stat.ftype[0])
    print get_mode_str(format('%o', stat.mode)[-3..])
    print ' '
    print stat.nlink
    print ' '
    print Etc.getpwuid(stat.uid).name.ljust(max_word_count_file_owner)
    print ' '
    print Etc.getgrgid(stat.gid).name.ljust(max_word_count_file_group)
    print ' '
    print stat.size.to_s.rjust(max_digit_file_size)
    print ' '
    print stat.ctime.strftime('%b %d %H:%M')
    print ' '
    puts file
  end
end

def get_mode_str(mode)
  result = []
  mode.each_char do |char|
    num = char.to_i
    result << (num & 0b100 == 0b100 ? 'r' : '-')
    result << (num & 0b010 == 0b010 ? 'w' : '-')
    result << (num & 0b001 == 0b001 ? 'x' : '-')
  end
  result.join
end

def output_default(files)
  rows_num = get_rows_num(files)
  column_width = get_column_width(files)
  (1..rows_num).each do |r|
    (1..COLUMN_NUM).each do |c|
      file_idx = (rows_num * (c - 1)) + r - 1
      next if file_idx >= files.length

      print_file(files[file_idx], column_width)
    end
    puts ''
  end
end

def get_column_width(files)
  files.max_by(&:length).length + 1
end

def print_file(file, column_width)
  space_num = column_width - file.length
  print file + ' ' * space_num
end

def get_rows_num(files)
  files.length.fdiv(COLUMN_NUM).ceil
end

main
