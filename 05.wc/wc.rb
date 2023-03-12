
def main
  ARGV.each do |file_path|
    output_file_info(file_path)
  end
end

def output_file_info(file_path)
  File.open(file_path, 'r') do |file|
    content = file.read
    puts [
      content.lines.length,
      content.split.length,
      content.bytesize,
      file.path
    ].join(' ')
  end
end

main
