require 'json'

require_relative 'kill'
require_relative 'player'

class Game
  attr_reader :game_name, :players, :kills

  def initialize(game_name)
    @game_name = game_name
    @kills = []
    # {:player_name => Player.new}
    @players = {}
  end

  def deal_with_kill_event(killer, killed, kill_reason)
    @players[killer] ||= Player.new(killer)
    @players[killed] ||= Player.new(killed)

    @kills << Kill.new(@players[killer], @players[killed], kill_reason)
    @players[killer].kill(@players[killed])
  end

  def player_names
    real_players.keys
  end

  def total_kills
    @kills.length
  end

  def real_players
    @players.select {|key, _| key != '<world>'}
  end

  def output_game_hash
    kills_info = {}
    score_info = {}
    real_players.each do |name, player|
      kills_info[name] = player.kill_times
      score_info[name] = player.get_score
    end

    { @game_name => { total_kills: total_kills,
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