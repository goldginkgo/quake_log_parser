require 'kill'
require 'player'

class Game
  attr_reader :players

  def initialize(game_name)
    @game_name = game_name
    @kills = []
    # {:player_name => Player.new}
    @players = {}
  end

  def deal_with_kill_event(killer, killed, kill_reason)
    @players[killer] ||= Player.new(killer) unless killer == "<world>"
    @players[killed] ||= Player.new(killed)

    if killer == "<world>" || killer == killed
      @players[killed].commit_a_suicide
    else
      @players[killer].kill_other_player
      @players[killed].killed_by_other_player
    end

  end
end