# frozen_string_literal: true

require_relative 'file_data'

class FilesDataGetter
  def initialize(all, reverse)
    @all = all
    @reverse = reverse
  end

  def get
    file_names = @all ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
    files_data = file_names.map { |file_name| FileData.new(file_name) }
    files_data.reverse! if @reverse
    files_data
  end
end
