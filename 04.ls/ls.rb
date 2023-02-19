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
  params[:l] ? output_1columns(files) : output_3columns(files)
end

def output_1columns(files)
  files.each do |file|
    stat = File.stat(file)
    stat.ftype == 'file' ? print('-') : print(stat.ftype[0])
    print_mode(stat.mode) 
    print ' '
    print stat.nlink
    print ' '
    print Etc.getpwuid(stat.uid).name
    print ' '
    print Etc.getgrgid(stat.gid).name
    print ' '
    print stat.size
    print ' '
    print stat.ctime.strftime('%b %d %H:%M')
    print ' '
    puts file
  end
end

def print_mode(mode)
  mode = sprintf("%o", mode)[-3..-1]
  mode.each_char do |char|
    num = char.to_i
    num >= 4 ? print('r') : print('-')
    num % 4 >= 2 ? print('w') : print('-')
    num % 2 ==1 ? print('x') : print('-')
  end
end

def output_3columns(files)
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
