require 'tile'

class Board
  attr_reader :size, :bomb_count, :grid

  def initialize(size = 9, bomb_count = 10)
    @bomb_count = bomb_count
    @size = size
    populate
  end

  def populate
    temp_grid = []
    bomb_count.times { temp_grid << Tile.new(true) }
    (size**2 - bomb_count).times { temp_grid << Tile.new }
    @grid = temp_grid.shuffle.each_slice(size).to_a
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    grid[x][y] = value
  end

  def won?
    grid.flatten.select { |tile| !tile.revealed && !tile.is_a_bomb}.empty?
  end

  def game_over?(pos)
    self[pos].is_a_bomb == true
  end

  def render
    display = grid.flatten.map do |tile|
      if tile.revealed
        tile.bomb_count.zero? ? " " : "#{tile.bomb_count}"
      else
        "*"
      end
    end
    puts display.each_slice(size).to_a
  end

end
