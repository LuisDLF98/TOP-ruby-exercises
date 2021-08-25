class Tictactoe
    attr_accessor :grid, :positions, :current_turn

    def initialize(first_player = false)
        @grid = Array.new(3) { Array.new(3) {" "}}
        @positions = {
            "a1" => [0,0],
            "a2" => [0,1],
            "a3" => [0,2],
            "b1" => [1,0],
            "b2" => [1,1],
            "b3" => [1,2],
            "c1" => [2,0],
            "c2" => [2,1],
            "c3" => [2,2],
        }
        @current_turn = first_player #boolean false is "x", true is "o"
    end

    def take_turn(move)
       if @current_turn
         @grid[@positions[move][0]][@positions[move][1]] = "O"
       else
         @grid[@positions[move][0]][@positions[move][1]] = "X" 
       end
    end

    def print
        puts "  |1|2|3"
        puts "--------"
        puts "a |#{@grid[0][0]}|#{@grid[0][1]}|#{@grid[0][2]}"
        puts "b |#{@grid[1][0]}|#{@grid[1][1]}|#{@grid[1][2]}"
        puts "c |#{@grid[2][0]}|#{@grid[2][1]}|#{@grid[2][2]}"
    end

    def valid(position)
        @grid[@positions[position][0]][@positions[position][1]].eql?(" ")
    end

    def start
        loop do
            puts "Select a position"
            input = gets.chomp

            # Loop until the player inputs an open position
            until valid(input) do
                puts "Select a position"
                input = gets.chomp
            end
            
            take_turn(input)
            @current_turn = !@current_turn

            self.print
        end
    end
end

puts "Is the first player x or o?"
input = gets.chomp

isX = false
isX = true if input.eql?("o")

game = Tictactoe.new(isX)
game.start