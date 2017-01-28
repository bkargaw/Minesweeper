class Tile
  attr_reader :revealed, :is_a_bomb, :flaged
  attr_accessor :bomb_count, :is_fring

  def initialize(is_a_bomb = false)
    @revealed = false
    @is_a_bomb = is_a_bomb
    @bomb_count = 0
    @is_fring = false
    @flaged = false
  end

  def reveal
    @revealed = true
  end

  def change_flag
    @flaged = !flaged
  end

  def update_if_fring
    @is_fring = true unless bomb_count == 0
  end

end
