
def main
  File.open(ARGV[0], 'r') do |file|
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
