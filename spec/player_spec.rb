require 'player'

describe Player do
  let(:player) { Player.new("Example player") }

  describe "#kill_other_player" do
    it "should increase kill times when player kills another player" do
      player.kill_other_player
      expect(player.kill_times).to eq(1)
    end
  end

  describe "#killed_by_other_player" do
    it "should increase no suicide death times when player is killed by another player" do
      player.killed_by_other_player
      expect(player.no_suicide_death_times).to eq(1)
    end
  end

  describe "#commit_a_suicide" do
    it "should increase suicide times when player commits a suicide" do
      player.commit_a_suicide
      expect(player.suicide_times).to eq(1)
    end
  end
end