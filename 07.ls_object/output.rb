# frozen_string_literal: true

require_relative 'default_outputter'
require_relative 'long_outputter'

class Output
  def self.generate(options)
    if options['l']
      LongOutputter.new(options['a'], options['r']).output
    else
      DefaultOutputter.new(options['a'], options['r']).output
    end
  end
end
