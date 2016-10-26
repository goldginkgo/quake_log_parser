require 'game'

describe Game do
  let(:game) { Game.new("game_1") }

  describe "#get_player_by_name" do
    it "should get player successfully" do
      game.deal_with_kill_event('test1', 'test2', 'MOD_RAILGUN')
      expect(game.get_player_by_name('test1')).to be_truthy
      expect(game.get_player_by_name('test2')).to be_truthy
    end
  end

  describe "#deal_with_kill_event" do
    it "should deal with no suicide kill event successfully" do
      game.deal_with_kill_event('test1', 'test2', 'MOD_RAILGUN')
      player = game.get_player_by_name('test1')
      expect(player.kill_times).to eq(1)
      expect(player.no_suicide_death_times).to eq(0)
      expect(player.suicide_times).to eq(0)

      player = game.get_player_by_name('test2')
      expect(player.kill_times).to eq(0)
      expect(player.no_suicide_death_times).to eq(1)
      expect(player.suicide_times).to eq(0)
    end

    it "should deal with kill by <world> event successfully" do
      game.deal_with_kill_event('<world>', 'test3', 'MOD_TRIGGER_HURT')
      player = game.get_player_by_name('test3')
      expect(player.kill_times).to eq(0)
      expect(player.no_suicide_death_times).to eq(0)
      expect(player.suicide_times).to eq(1)
    end

    it "should deal with kill by self event successfully" do
      game.deal_with_kill_event('<world>', 'test4', 'MOD_TRIGGER_HURT')
      player = game.get_player_by_name('test4')
      expect(player.kill_times).to eq(0)
      expect(player.no_suicide_death_times).to eq(0)
      expect(player.suicide_times).to eq(1)
    end
  end

  describe "#output_game_hash" do
    it "output the game information successfully" do
      expect_output_info = {"game_1"=>{:total_kills=>0, :players=>[], :kills=>{}}}
      expect(game.output_game_hash).to eq(expect_output_info)
      # add a no suicide kill event
      game.deal_with_kill_event('test1', 'test2', 'MOD_RAILGUN')
      expect_output_info = {"game_1" => {:total_kills => 1,
                                         :players => ["test1", "test2"],
                                         :kills => {"test1" => 1, "test2" => 0}}}
      expect(game.output_game_hash).to eq(expect_output_info)
      # add a kill by <world> event
      game.deal_with_kill_event('<world>', 'test1', 'MOD_TRIGGER_HURT')
      expect_output_info = {"game_1" => {:total_kills => 2,
                                         :players => ["test1", "test2"],
                                         :kills => {"test1" => 0, "test2" => 0}}}
      expect(game.output_game_hash).to eq(expect_output_info)
      # add a kill by self event
      game.deal_with_kill_event('<world>', 'test2', 'MOD_TRIGGER_HURT')
      expect_output_info = {"game_1" => {:total_kills => 3,
                                         :players => ["test1", "test2"],
                                         :kills => {"test1" => 0, "test2" => -1}}}
      expect(game.output_game_hash).to eq(expect_output_info)
    end
  end

  describe "#generate_aggregation_kill_reasons_hash" do
    it "generate aggregation kill reasons successfully" do
      game.deal_with_kill_event('test1', 'test2', 'MOD_RAILGUN')
      game.deal_with_kill_event('<world>', 'test1', 'MOD_TRIGGER_HURT')
      game.deal_with_kill_event('<world>', 'test2', 'MOD_ROCKET_SPLASH')
      game.deal_with_kill_event('test4', 'test1', 'MOD_ROCKET_SPLASH')

      expect_info = {"game_1" => {:kills_by_means => { "MOD_RAILGUN" => 1,
                                                       "MOD_TRIGGER_HURT" => 1,
                                                       "MOD_ROCKET_SPLASH" => 2}}}
      expect(game.generate_aggregation_kill_reasons_hash).to eq(expect_info)
    end
  end
end