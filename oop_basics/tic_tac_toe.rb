class Tictactoe
    attr_accessor :grid, :positions, :current_symbol, :current_player

    def initialize(player_symbol = false)
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
        @current_symbol = player_symbol # Boolean false is "X", true is "O"
        @current_player = 1
    end

    # Places the current player's move onto the board
    def take_turn(position)
       if @current_symbol
         @grid[@positions[position][0]][@positions[position][1]] = "O"
       else
         @grid[@positions[position][0]][@positions[position][1]] = "X" 
       end
    end

    # Print the game board into the terminal
    def print
        puts "  |1|2|3"
        puts "--------"
        puts "a |#{@grid[0][0]}|#{@grid[0][1]}|#{@grid[0][2]}"
        puts "--------"
        puts "b |#{@grid[1][0]}|#{@grid[1][1]}|#{@grid[1][2]}"
        puts "--------"
        puts "c |#{@grid[2][0]}|#{@grid[2][1]}|#{@grid[2][2]}"
    end

    # Checks if a move is valid
    # Valid move is one that is one the board and not already taken
    def valid(position)
        @positions.has_key?(position) && @grid[@positions[position][0]][@positions[position][1]].eql?(" ")
    end

    def player_won
        self.print
        puts "Player #{@current_player} won!"
        return true
    end

    # Check is the current player won the game
    def is_win?
        if @grid.any? { |row| row.all? { |space| space == "X" } } || @grid.any? { |row| row.all? { |space| space == "O" } }
            # Check the rows of the board

            return self.player_won
        elsif @grid[0][0] != " " && @grid[0][0] == @grid[1][0] && @grid[0][0] == @grid[2][0]
            # Check the first column of the board
            
            return self.player_won
        elsif @grid[0][1] != " " && @grid[0][1] == @grid[1][1] && @grid[0][1] == @grid[2][1]
            # Check the second column of the board

            return self.player_won
        elsif @grid[0][2] != " " && @grid[0][2] == @grid[1][2] && @grid[0][2] == @grid[2][2]
            # Check the third column of the board

            return self.player_won
        elsif @grid[0][0] != " " && @grid[0][0] == @grid[1][1] && @grid[0][0] == @grid[2][2]
            # Check the right diagonal of the board

            return self.player_won
        elsif @grid[0][2] != " " && @grid[0][2] == @grid[1][1] && @grid[0][2] == @grid[2][0]
            # Check the left diagonal of the board

            return self.player_won
        else
            return false
        end
    end

    def is_tie?
        if @grid.all? { |row| row.none? { |space| space == " " } }
            self.print
            puts "The players tied!"
            return true
        else 
            return false
        end
    end

    # Start up the game
    def start
        loop do
            self.print

            puts "Player #{@current_player} select a position"
            input = gets.chomp

            # Loop until the player inputs an open position
            until valid(input) do
                puts "Player #{@current_player} select a position"
                input = gets.chomp
            end
            
            take_turn(input)
            break if self.is_win? || self.is_tie?

            @current_symbol = !@current_symbol
            @current_player = (@current_player % 2) + 1
        end
    end
end

puts "Player 1 choose a valid symbol (X or O)"
input = gets.chomp

# Loop until the player inputs an valid symbol
until input.upcase == "X" || input.upcase == "O" do
    puts "Player 1 select a valid symbol"
    input = gets.chomp
end

isX = false
isX = true if input.upcase.eql?("O")

game = Tictactoe.new(isX)
game.start