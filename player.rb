class Player
  attr_reader :name

  def initialize
    puts "what is your name"
    @name = gets.chomp.strip.capitalize
  end

  def get_move
    puts "Hay #{name}, what is your next move e.g. f:0,1 or r:0,2"
    puts "NOTE: f - flag || unflag ; r - reveal"
    begin
      type, pos = gets.chomp.split(":")
      pos = pos.split(",").map { |val| Integer(val.strip) }
      raise "error" unless ["F", "R"].map { |el| el == type.strip.upcase }.any?
      [type.upcase, pos]
    rescue
      puts "Invalid moves"
      get_move
    end
  end

end
