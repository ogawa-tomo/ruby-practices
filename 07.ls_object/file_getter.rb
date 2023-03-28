# frozen_string_literal: true

class FileGetter
  def initialize(all, reverse)
    @all = all
    @reverse = reverse
  end

  def get
    files = @all ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
    files.reverse! if @reverse
    files
  end
end