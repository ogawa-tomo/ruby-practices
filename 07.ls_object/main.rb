#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
require_relative 'default_outputter'

def main
  options = ARGV.getopts('a', 'r', 'l')
  files = get_files(options['a'], options['r'])
  options['l'] ? output_long(files) : DefaultOutputter.new(files).output
end

def get_files(all, reverse)
  files = all ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
  files.reverse! if reverse
  files
end

def output_long(files)
  max_digit_file_link = files.map { |file| File.stat(file).nlink }.max.to_s.length
  max_word_count_file_owner = files.map { |file| Etc.getpwuid(File.stat(file).uid).name.size }.max
  max_word_count_file_group = files.map { |file| Etc.getgrgid(File.stat(file).gid).name.size }.max
  max_digit_file_size = files.map { |file| File.stat(file).size }.max.to_s.length

  puts "total #{files.map { |file| File.stat(file).blocks }.sum / 2}"
  files.each do |file|
    stat = File.stat(file)
    stat.ftype == 'file' ? print('-') : print(stat.ftype[0])
    puts [
      get_mode_str(format('%o', stat.mode)[-3..]),
      stat.nlink.to_s.rjust(max_digit_file_link),
      Etc.getpwuid(stat.uid).name.ljust(max_word_count_file_owner),
      Etc.getgrgid(stat.gid).name.ljust(max_word_count_file_group),
      stat.size.to_s.rjust(max_digit_file_size),
      stat.ctime.strftime('%b %e %H:%M'),
      file
    ].join(' ')
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

main
