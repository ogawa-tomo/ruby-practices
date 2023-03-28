# frozen_string_literal: true

class LongFilesDataOutputter
  def initialize(files_data)
    @files_data = files_data
  end

  def output
    max_digit_file_link = @files_data.map { |data| data.nlink }.max.to_s.length
    max_word_count_file_owner = @files_data.map { |data| data.owner.size }.max
    max_word_count_file_group = @files_data.map { |data| data.group.size }.max
    max_digit_file_size = @files_data.map { |data| data.size }.max.to_s.length

    puts "total #{@files_data.map { |data| data.blocks }.sum}"
    @files_data.each do |data|
      print data.ftype
      puts [
        data.mode,
        data.nlink.to_s.rjust(max_digit_file_link),
        data.owner.ljust(max_word_count_file_owner),
        data.group.ljust(max_word_count_file_group),
        data.size.to_s.rjust(max_digit_file_size),
        data.ctime,
        data.name
      ].join(' ')
    end
  end
end
