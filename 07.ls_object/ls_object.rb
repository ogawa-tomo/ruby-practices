#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

require_relative 'files_data_outputter'

options = ARGV.getopts('a', 'r', 'l')
FilesDataOutputter.new(options).output
