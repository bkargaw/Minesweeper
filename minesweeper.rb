require_relative 'board'
require_relative 'player'

class Minesweeper
  attr_reader :player, :board
  def initialize(board, player)
    @board = board
    @player = player
  end

  def run
    system('clear')
    render
    loop do
      type, pos = player.get_move

      if board[pos].is_a_bomb && type != "F"
        board.reavel_when_game_lose
        system('clear')
        puts "BOOM!! Game Over!"
        render
        break

      else
        run_turn(type, pos)
      end
    end
  end

  def run_turn(type, pos)
    case type
    when 'F' # flag move
      board.change_flag pos
    when 'R'
      board.reveal pos
    end
    system('clear')
    puts "board after move"
    board.render
  end

  def render
    board.render
  end

end
if __FILE__ == $PROGRAME_NAME
  system('clear')
  board = Board.new(9, 10)
  player = Player.new
  game = Minesweeper.new(board, player)
  game.run
end
