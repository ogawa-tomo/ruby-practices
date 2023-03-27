#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
require_relative 'default_outputter'
require_relative 'long_outputter'

def main
  options = ARGV.getopts('a', 'r', 'l')
  files = get_files(options['a'], options['r'])
  options['l'] ? LongOutputter.new(files).output : DefaultOutputter.new(files).output
end

def get_files(all, reverse)
  files = all ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
  files.reverse! if reverse
  files
end

main
