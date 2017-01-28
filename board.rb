require_relative 'tile'
require 'colorize'

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
        tile.bomb_count = count_bombs([i, j])
        tile.update_if_fring
      end
    end
  end

  def count_bombs(location)
    get_my_neighbor_pos(location).select do |pos|
      self[pos].is_a_bomb
    end.count
  end

  def get_my_neighbor_pos(pos)
    positions = []
    i, j = pos
    (i - 1..i + 1).each do |i2|
      (j - 1..j + 1).each do |j2|
        positions << [i2, j2] unless [i2, j2] == pos
      end
    end
    positions.select do |i3, j3|
      i3.between?(0, size - 1) && j3.between?(0, size - 1)
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
    grid.flatten.select { |tile| !tile.revealed && !tile.is_a_bomb }.empty?
  end

  def game_over?(pos)
    self[pos].is_a_bomb == true
  end

  def render
    display = grid.flatten.map do |tile|
      if tile.revealed
        if tile.is_a_bomb
          "@".red # bomb
        else
          tile.bomb_count.zero? ? "*".light_black : tile.bomb_count.to_s.yellow
        end
      else
        tile.flaged ? "F".cyan : "-"
      end
    end
    display_this(display)
  end

  def display_this(display)
    puts " #{[*0...size].join(" ")}"
    display.each_slice(size).to_a.each_with_index do |row, row_idx|
      print row_idx.to_s
      row.each_with_index do  |el, el_idx|
        el_idx + 1 != size ?  print("#{el} ") : puts("#{el} ")
      end
    end
  end

  require 'byebug'

  def reveal(pos)
    tile = self[pos]
    unless tile.revealed || tile.is_a_bomb || tile.flaged
      tile.reveal
      unless tile.is_fring
        get_my_neighbor_pos(pos).map { |other_tile| reveal(other_tile) }
      end
    end

    tile
  end

  def reavel_when_game_lose
    grid.each { |row| row.each(&:reveal) }
  end

  def change_flag(pos)
    tile = self[pos]
    tile.change_flag unless tile.revealed
  end

end
