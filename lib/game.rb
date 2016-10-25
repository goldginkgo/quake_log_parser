require 'kill'
require 'player'

class Game
  def initialize(game_lines, game_name)
    @game_lines = game_lines
    @game_name = game_name
    @kills = []
    @players = []
  end
end