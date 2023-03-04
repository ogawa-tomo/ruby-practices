#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

COLUMN_NUM = 3

def main
  opt = OptionParser.new
  params = {}
  opt.on('-a') { |v| params[:a] = v }
  opt.on('-r') { |v| params[:r] = v }
  opt.on('-l') { |v| params[:l] = v }
  opt.parse!(ARGV)

  files = Dir.glob('*')
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
