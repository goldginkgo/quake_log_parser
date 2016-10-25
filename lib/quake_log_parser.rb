require 'log_utils'
require 'game'

class QuakeLogParser
  include LogUtils

  attr_reader :games

  def initialize(log_file = get_log_file_path)
    @log_file = log_file
    @games = []
    @current_game = nil
  end

  def parse_log_file
    read_from_file(@log_file) do |file|
      file.each do |line|
        if game_start?(line)
          game_name = "game_#{@games.length + 1}"
          @current_game = Game.new(game_name)
        elsif kill_event?(line)
          killer, killed, kill_reason = get_kill_info_from_kill_event(line)
          @current_game.deal_with_kill_event(killer, killed, kill_reason)
        elsif game_over?(line)
          @games << @current_game if @current_game && !@games.include?(@current_game)
        else
          next
        end
      end
    end
  end
end