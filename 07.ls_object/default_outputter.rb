# frozen_string_literal: true

require_relative 'outputter'

class DefaultOutputter < Outputter
  COLUMN_NUM = 3

  def initialize(all, reverse)
    super(all, reverse)
    @rows_num = get_rows_num
    @column_width = get_column_width
  end

  def output
    (1..@rows_num).each do |r|
      (1..COLUMN_NUM).each do |c|
        file_idx = (@rows_num * (c - 1)) + r - 1
        next if file_idx >= @files.length

        print_file(@files[file_idx])
      end
      puts ''
    end
  end

  private

  def get_column_width
    @files.max_by(&:length).length + 1
  end

  def print_file(file)
    space_num = @column_width - file.length
    print file + ' ' * space_num
  end

  def get_rows_num
    @files.length.fdiv(COLUMN_NUM).ceil
  end
end