require_relative 'tile'

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
    assign_bomb_count
  end

  def assign_bomb_count
    grid.each.with_index do |row, i|
      row.each.with_index do |tile, j|
        next if tile.is_a_bomb
        tile.bomb_count = count_bombs
      end
    end
  end

  def count_bombs
    get_my_neighbor_positions([i, j]).select do |pos|
      board[pos].is_a_bomb
    end.count
  end

  def get_my_neighbor_positions(pos)
    positions = []

    i, j = pos
    (i-1..i+1).each do |i2|
      (j-1..j+1).each do |j2|
        positions << [i2, j2] unless [i2, j2] == pos
      end
    end
    positions.select do |i3, j3|
      i3.between?(0, size - 1) && j3.between? (0, size - 1)
    end
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
    display.each_slice(size).to_a.each{|row| p row.join(" ")}
  end

end
