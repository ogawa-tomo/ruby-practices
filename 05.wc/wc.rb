
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
  files_data.each do |file_data|
    puts [
      file_data[:content].lines.length,
      file_data[:content].split.length,
      file_data[:content].bytesize,
      file_data[:name]
    ].join(' ')
  end
end

main
