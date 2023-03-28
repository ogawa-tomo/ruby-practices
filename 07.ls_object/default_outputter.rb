# frozen_string_literal: true

class DefaultOutputter
  COLUMN_NUM = 3

  def initialize(files_data)
    @files_data = files_data
  end

  def output
    (1..rows_num).each do |r|
      (1..COLUMN_NUM).each do |c|
        file_idx = (rows_num * (c - 1)) + r - 1
        next if file_idx >= @files_data.length

        print_file(@files_data[file_idx])
      end
      puts ''
    end
  end

  private

  def column_width
    @column_width ||= @files_data.map(&:name).max_by(&:length).length + 1
  end

  def rows_num
    @rows_num ||= @files_data.map(&:name).length.fdiv(COLUMN_NUM).ceil
  end

  def print_file(file_data)
    space_num = column_width - file_data.name.length
    print file_data.name + ' ' * space_num
  end
end
