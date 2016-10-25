require 'game'

describe Game do
  let(:game) { Game.new("game_1") }

  describe "#deal_with_kill_event" do
    it "should deal with no suicide kill event successfully" do
      game.deal_with_kill_event('test1', 'test2', 'MOD_RAILGUN')

      expect(game.players['test1'].kill_times).to eq(1)
      expect(game.players['test1'].no_suicide_death_times).to eq(0)
      expect(game.players['test1'].suicide_times).to eq(0)

      expect(game.players['test2'].kill_times).to eq(0)
      expect(game.players['test2'].no_suicide_death_times).to eq(1)
      expect(game.players['test2'].suicide_times).to eq(0)
    end

    it "should deal with kill by <world> event successfully" do
      game.deal_with_kill_event('<world>', 'test3', 'MOD_TRIGGER_HURT')

      expect(game.players['test3'].kill_times).to eq(0)
      expect(game.players['test3'].no_suicide_death_times).to eq(0)
      expect(game.players['test3'].suicide_times).to eq(1)
    end

    it "should deal with kill by self event successfully" do
      game.deal_with_kill_event('<world>', 'test4', 'MOD_TRIGGER_HURT')

      expect(game.players['test4'].kill_times).to eq(0)
      expect(game.players['test4'].no_suicide_death_times).to eq(0)
      expect(game.players['test4'].suicide_times).to eq(1)
    end
  end
end