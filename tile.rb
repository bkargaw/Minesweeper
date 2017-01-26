class Tile
  attr_reader :revealed, :type
  attr_accessor :bomb_count

  def initialize(type = false)
    @revealed = false
    @is_a_bomb = type
    @bomb_count = 0
  end

  def reveal
    @revealed = true
  end

end
