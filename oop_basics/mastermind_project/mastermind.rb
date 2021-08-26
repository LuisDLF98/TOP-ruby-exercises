class Mastermind
    def initialize(type = false)
        @player_type = type
        @turns = 12
        @code = ""
        @pegs = {
            "r" => "    ".bg_red,
            "g" => "    ".bg_green,
            "y" => "    ".bg_yellow,
            "b" => "    ".bg_blue,
            "m" => "    ".bg_magenta,
            "c" => "    ".bg_cyan,
            "kr" => "o".red,
            "kg" => "o".grey,
            " " => " ".grey
        }
    end

    # Check if the guesser guessed correctly
    def is_right?(key_pegs)
        if key_pegs.all? { |peg| peg == "kr" }
            puts "Guesser won!"
            return true
        end
        return false
    end

    # Check if the guesser used all of their turns
    def no_turns?
        if @turns == 0
            puts "Creator won!"
            return true
        end
        return false
    end
    
    # Start the game
    def start
        puts "Type in a code"
        @code = gets.chomp

        loop do
            puts "Guess the code"
            guess = gets.chomp
            guess_list = guess.split("")
            @turns -= 1

            key_pegs = get_key_pegs(guess_list)
            self.print(guess_list, key_pegs)

            break if self.is_right?(key_pegs) || self.no_turns?
        end
    end

    # Get key_pegs based off of the guess
    # A red key peg (kr) corresponds to a code peg that was correct in color and position
    # A grey key peg (kg) corresponds to a code peg that was correct in only color
    def get_key_pegs(guess_list)
        key_pegs = [" ", " ", " ", " "]
        peg_idx = 0

        # TODO: Add a check so the amount of pegs given corresponds to the same amount of duplicates in the code
        guess_list.each_with_index do |code_peg, index|
            if @code.include?(code_peg)
                if (@code[index] = code_peg)
                    key_pegs[peg_idx] = "kr"
                else
                    key_pegs[peg_idx] = "kg"
                end
                peg_idx += 1
            end
        end
        return key_pegs
    end

    def print(guess_list, key_pegs)
        puts "---------------------------"
        puts "|#{@pegs[guess_list[0]]}|#{@pegs[guess_list[1]]}|#{@pegs[guess_list[2]]}|#{@pegs[guess_list[3]]}| #{@pegs[key_pegs[0]]} #{@pegs[key_pegs[1]]} | Turns left: #{(@turns).to_s}"
        puts "|#{@pegs[guess_list[0]]}|#{@pegs[guess_list[1]]}|#{@pegs[guess_list[2]]}|#{@pegs[guess_list[3]]}| #{@pegs[key_pegs[2]]} #{@pegs[key_pegs[3]]} |"
        puts "---------------------------"
    end
end