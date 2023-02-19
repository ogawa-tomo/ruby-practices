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
  puts "total #{files.map { |file| File.stat(file).blksize }.sum / 1024}"
  files.each do |file|
    stat = File.stat(file)
    stat.ftype == 'file' ? print('-') : print(stat.ftype[0])
    print get_mode_str(sprintf("%o", stat.mode)[-3..-1]) 
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

def get_mode_str(mode)
  result = []
  mode.each_char do |char|
    num = char.to_i
    num >= 4 ? result << 'r' : result << '-'
    num % 4 >= 2 ? result << 'w' : result << '-'
    num % 2 ==1 ? result << 'x' : result << '-'
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
