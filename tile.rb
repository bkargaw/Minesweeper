class Tile
  attr_reader :revealed, :type
  attr_accessor :bomb_count, :is_fring

  def initialize(type = false)
    @revealed = false
    @is_a_bomb = type
    @bomb_count = 0
    @is_fring = false
  end

  def reveal
    @revealed = true
  end

end
