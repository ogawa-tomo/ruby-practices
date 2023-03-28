# frozen_string_literal: true

require_relative 'default_outputter'
require_relative 'long_outputter'
require_relative 'file_getter'

class Output
  def self.generate(options)
    files = FileGetter.new(options['a'], options['r']).get
    if options['l']
      LongOutputter.new(files).output
    else
      DefaultOutputter.new(files).output
    end
  end
end
