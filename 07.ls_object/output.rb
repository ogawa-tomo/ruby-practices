# frozen_string_literal: true

require_relative 'default_files_data_outputter'
require_relative 'long_files_data_outputter'
require_relative 'files_data_getter'

class Output
  def self.generate(options)
    files_data = FilesDataGetter.new(options['a'], options['r']).get
    if options['l']
      LongFilesDataOutputter.new(files_data).output
    else
      DefaultFilesDataOutputter.new(files_data).output
    end
  end
end
