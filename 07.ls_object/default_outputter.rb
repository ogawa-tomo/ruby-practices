# frozen_string_literal: true

class DefaultOutputter
  COLUMN_NUM = 3

  def initialize(files)
    @files = files
  end

  def output
    (1..rows_num).each do |r|
      (1..COLUMN_NUM).each do |c|
        file_idx = (rows_num * (c - 1)) + r - 1
        next if file_idx >= @files.length

        print_file(@files[file_idx])
      end
      puts ''
    end
  end

  private

  def column_width
    @column_width ||= @files.max_by(&:length).length + 1
  end

  def rows_num
    @rows_num ||= @files.length.fdiv(COLUMN_NUM).ceil
  end

  def print_file(file)
    space_num = column_width - file.length
    print file + ' ' * space_num
  end
end
