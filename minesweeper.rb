require_relative 'board'

class Minesweeper

  def initialize(board)
    @board = board
  end

  def run

  end

  def run_turn
    
  end

end

def get_board_size
  puts "please tell me the size of the board you want to play on"
  begin
    Integer(gets.chomp.strip)
  rescue
    puts "invalid move"
    get_board_calss_info
  end
end
size = get_board_size
num_bomb = size * 2 / 3
board = Board.new(size, num_bomb)
game = Minesweeper(board)
game.run
