require 'log_utils'

class QuakeLogParser
  include LogUtils

  def initialize(log_file = get_log_file_path)
    @log_file = log_file
  end

  def parse_log_file
    read_from_file(@log_file) do |file|

    end
  end

end