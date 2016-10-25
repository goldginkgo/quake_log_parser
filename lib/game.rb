require 'kill'

class Game
  def initialize(game_lines, game_name)
    @game_lines = game_lines
    @game_name = game_name
    @kills = []
  end
end