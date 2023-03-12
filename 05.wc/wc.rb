
def main
  files_data = ARGV.map do |file_path|
    content = nil
    File.open(file_path) do |file|
      content = file.read
    end
    {
      name: file_path,
      content: content
    }
  end
  output_files_info(files_data)
end

def output_files_info(files_data)
  max_digit_line_count = files_data.map { |file_data| file_data[:content].lines.length }.sum.to_s.length
  max_digit_word_count = files_data.map { |file_data| file_data[:content].split.length }.sum.to_s.length
  max_digit_file_size = files_data.map { |file_data| file_data[:content].bytesize }.sum.to_s.length

  files_data.each do |file_data|
    puts [
      file_data[:content].lines.length.to_s.rjust(max_digit_line_count),
      file_data[:content].split.length.to_s.rjust(max_digit_word_count),
      file_data[:content].bytesize.to_s.rjust(max_digit_file_size),
      file_data[:name]
    ].join(' ')
  end
  puts [
    files_data.map { |file_data| file_data[:content].lines.length }.sum.to_s.rjust(max_digit_line_count),
    files_data.map { |file_data| file_data[:content].split.length }.sum.to_s.rjust(max_digit_word_count),
    files_data.map { |file_data| file_data[:content].bytesize }.sum.to_s.rjust(max_digit_file_size),
    'total'
  ].join(' ') if files_data.length > 1
end

main
