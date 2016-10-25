module LogUtils
  LOG_FILE_NAME = "games.log"
  INIT_GAME_REGREX = /InitGame/
  END_GAME_REGREX = /-----/

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

  def game_start?(line)
    return true if line =~ INIT_GAME_REGREX
    return false
  end

  def game_over?(line)
    return true if line =~ END_GAME_REGREX
    return false
  end
end