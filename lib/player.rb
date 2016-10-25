class Player
  attr_reader :name, :kill_times, :no_suicide_death_times, :suicide_times

  def initialize(name, kill_times = 0, no_suicide_death_times = 0, suicide_times = 0)
    @name = name
    @kill_times = kill_times
    @no_suicide_death_times = no_suicide_death_times
    @suicide_times = suicide_times
  end

  def kill_other_player
    @kill_times += 1
  end

  def killed_by_other_player
    @no_suicide_death_times += 1
  end

  def commit_a_suicide
    @suicide_times += 1
  end

  def get_score
    @kill_times - @no_suicide_death_times - @suicide_times
  end
end