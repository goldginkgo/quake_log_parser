require 'json'

require_relative 'kill'
require_relative 'player'

class Game
  attr_reader :game_name, :players, :total_kills, :kills

  def initialize(game_name)
    @game_name = game_name
    @kills = []
    # {:player_name => Player.new}
    @players = {}
    @total_kills = 0
  end

  def deal_with_kill_event(killer, killed, kill_reason)
    @kills << Kill.new(killer, killed, kill_reason)
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
    score_info = {}
    @players.each do |name, player|
      kills_info[name] = player.kill_times
      score_info[name] = player.get_score
    end

    @players.each { |name, player| kills_info[name] = player.kill_times }
    { @game_name => { total_kills: @total_kills,
                      players: player_names,
                      kills: kills_info,
                      scores: score_info}
    }
  end

  def to_s
    JSON.pretty_generate(output_game_hash)
  end

  def display_aggregation_kill_reasons
    JSON.pretty_generate(generate_aggregation_kill_reasons_hash)
  end

  def generate_aggregation_kill_reasons_hash
    kill_reasons = {}
    @kills.each do |kill|
      kill_reasons[kill.kill_reason] ||= 0
      kill_reasons[kill.kill_reason] += 1
    end
    { @game_name => { kills_by_means: kill_reasons}}
  end
end