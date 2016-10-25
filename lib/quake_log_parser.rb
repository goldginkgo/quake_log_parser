require 'log_utils'
require 'game'

class QuakeLogParser
  include LogUtils

  attr_reader :games

  def initialize(log_file = get_log_file_path)
    @log_file = log_file
    @games = []
  end

  def parse_log_file
    read_from_file(@log_file) do |file|
      current_game_lines = []
      file.each do |line|
        if game_start?(line)
          current_game_lines = []
        elsif game_over?(line)
          @games << Game.new(current_game_lines)
        else
          current_game_lines << line
        end
      end
    end
  end

end