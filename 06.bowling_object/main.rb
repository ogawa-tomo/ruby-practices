#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'game'

mark_data = ARGV[0].split(',')
game = Game.new(mark_data)
puts game.calc_score()
