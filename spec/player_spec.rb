require 'player'

describe Player do
  let(:player1) { Player.new("Example player1") }
  let(:player2) { Player.new("Example player2") }
  let(:player3) { Player.new("<world>") }
  let(:player4) { Player.new("Example player3", 5, 2, 1) }
  let(:player5) { Player.new("Example player1") }

  describe "#kill" do
    it "should increase kill times when player kills another player" do
      player1.kill(player2)
      expect(player1.kill_times).to eq(1)
      expect(player2.no_suicide_death_times).to eq(1)
    end

    it "should increase suicide times when player kills himself" do
      player1.kill(player1)
      expect(player1.suicide_times).to eq(1)
    end

    it "should increase suicide times when player is killed by <world>" do
      player3.kill(player1)
      expect(player1.suicide_times).to eq(1)
    end
  end

  describe "#get_score" do
    it "should get score 0 when player has no kill events" do
      expect(player1.get_score).to eq(0)
    end

    it "should get correct score when player has kill events" do
      expect(player4.get_score).to eq(4)
    end
  end

  describe "#==" do
    it "should be true when comparing same player" do
      expect(player1).to be == player5
    end

    it "should be false when comparing two players" do
      expect(player1).not_to be == player2
    end
  end
end