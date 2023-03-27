# frozen_string_literal: true

class OutputterBase
  def initialize(all, reverse)
    @files = get_files(all, reverse)
  end

  def output
    raise 'Not implemented.'
  end

  private

  def get_files(all, reverse)
    files = all ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
    files.reverse! if reverse
    files
  end
end