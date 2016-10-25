module LogUtils
  LOG_FILE_NAME = "games.log"

  def get_log_file_path
    File.expand_path("../../quake_logs/#{LOG_FILE_NAME}", __FILE__)
  end

  def read_from_file(filename)
    file = File.open(filename, 'r')
    yield file if block_given?
  rescue Errno::ENOENT => ex
    puts "File not found: #{filename}"
    raise ex
  rescue Errno::EACCES => ex
    puts "File permission denied: #{filename}"
    raise ex
  rescue => ex
    puts "IO error: #{ex.message}"
    raise ex
  ensure
    file.close if file
  end
end