#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

require_relative 'output'

options = ARGV.getopts('a', 'r', 'l')
Output.generate(options)
