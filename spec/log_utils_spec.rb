require 'log_utils'

describe LogUtils do

  let(:extended_class) { Class.new { extend LogUtils } }

  describe "#read_from_file" do
    it "should raise error when file not found" do
      expect { extended_class.read_from_file("not_exist_file") }.to raise_error(Errno::ENOENT)
    end

    it "should not raise error when file exist" do
      expect { extended_class.read_from_file(extended_class.get_log_file_path) }.not_to raise_error
    end
  end

  describe "#game_start?" do
    it "should be true if the line is a starting line" do
      line = '0:00 InitGame: \sv_floodProtect\1\sv_maxPing\0\sv_minPing\0\sv_maxRate\10000\sv_minRate\0\sv_hostname\Code Miner Server\g_gametype\0\sv_privateClients\2\sv_maxclients\16\sv_allowDownload\0\dmflags\0\fraglimit\20\timelimit\15\g_maxGameClients\0\capturelimit\8\version\ioq3 1.36 linux-x86_64 Apr 12 2009\protocol\68\mapname\q3dm17\gamename\baseq3\g_needpass\0'
      expect(extended_class.game_start?(line)).to be true
    end

    it "should be false if the line is not a starting line" do
      line = "3:32 ClientConnect: 2"
      expect(extended_class.game_start?(line)).to be false
    end
  end

  describe "#game_over?" do
    it "should be true if the line is an ending line" do
      line = " 20:37 ------------------------------------------------------------"
      expect(extended_class.game_over?(line)).to be true
    end

    it "should be false if the line is not an ending line" do
      line = "3:32 ClientConnect: 2"
      expect(extended_class.game_over?(line)).to be false
    end
  end
end