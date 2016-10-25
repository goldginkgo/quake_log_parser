require 'json'

require 'kill'
require 'player'

class Game
  attr_reader :game_name, :players, :total_kills

  def initialize(game_name)
    @game_name = game_name
    @kills = []
    # {:player_name => Player.new}
    @players = {}
    @total_kills = 0
  end

  def deal_with_kill_event(killer, killed, kill_reason)
    @total_kills += 1

    @players[killer] ||= Player.new(killer) unless killer == "<world>"
    @players[killed] ||= Player.new(killed)

    if killer == "<world>" || killer == killed
      @players[killed].commit_a_suicide
    else
      @players[killer].kill_other_player
      @players[killed].killed_by_other_player
    end

  end

  def player_names
    @players.keys
  end

  def output_game_hash
    kills_info = {}
    @players.each { |name, player| kills_info[name] = player.no_suicide_death_times }
    { @game_name => { total_kills: @total_kills,
                      players: player_names,
                      kills: kills_info}
    }
  end

  def to_s
    JSON.pretty_generate(output_game_hash)
  end
end