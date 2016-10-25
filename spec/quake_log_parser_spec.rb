require 'quake_log_parser'

describe QuakeLogParser do

  describe "#parse_log_file" do
    it "should return the correct number of games" do
      parser = QuakeLogParser.new
      parser.parse_log_file
      expect(parser.games.length).to eq(21)
    end
  end
end