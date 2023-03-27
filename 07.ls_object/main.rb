#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
require_relative 'default_outputter'
require_relative 'long_outputter'

def main
  options = ARGV.getopts('a', 'r', 'l')
  options['l'] ? LongOutputter.new(options['a'], options['r']).output : DefaultOutputter.new(options['a'], options['r']).output
end

main
