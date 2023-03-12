require 'optparse'

def main
  options = ARGV.getopts('l', 'c', 'w')
  files_data = get_files_data(ARGV)
  output_files_info(files_data, options)
end

def get_files_data(files_path)
  files_path.map do |file_path|
    content = nil
    File.open(file_path) do |file|
      content = file.read
    end
    {
      name: file_path,
      content: content
    }
  end
end

def output_files_info(files_data, options)
  line_count_digit = get_total_line_count(files_data).to_s.length
  word_count_digit = get_total_word_count(files_data).to_s.length
  file_size_digit = get_total_file_size(files_data).to_s.length

  files_data.each do |file_data|
    puts [
      output_line_count?(options) ? file_data[:content].lines.length.to_s.rjust(line_count_digit) : '',
      output_word_count?(options) ? file_data[:content].split.length.to_s.rjust(word_count_digit) : '',
      output_file_size?(options) ? file_data[:content].bytesize.to_s.rjust(file_size_digit) : '',
      file_data[:name]
    ].join(' ')
  end

  puts [
    output_line_count?(options) ? get_total_line_count(files_data).to_s.rjust(line_count_digit) : '',
    output_word_count?(options) ? get_total_word_count(files_data).to_s.rjust(word_count_digit) : '',
    output_file_size?(options) ? get_total_file_size(files_data).to_s.rjust(file_size_digit) : '',
    'total'
  ].join(' ') if files_data.length > 1
end

def get_total_line_count(files_data)
  files_data.map { |file_data| file_data[:content].lines.length }.sum
end

def get_total_word_count(files_data)
  files_data.map { |file_data| file_data[:content].split.length }.sum
end

def get_total_file_size(files_data)
  files_data.map { |file_data| file_data[:content].bytesize }.sum
end

def output_line_count?(options)
  !options['l'] && !options['w'] && !options['c'] ? true : options['l'] 
end

def output_word_count?(options)
  !options['l'] && !options['w'] && !options['c'] ? true : options['w'] 
end

def output_file_size?(options)
  !options['l'] && !options['w'] && !options['c'] ? true : options['c'] 
end

main
