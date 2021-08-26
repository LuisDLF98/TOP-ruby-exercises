class Mastermind
    def initialize(type = false)
        @player_type = type
        @turns = 12
        @code = ""
        @S = []
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

    # Check if the guesser guessed correctly.
    def is_right?(key_pegs)
        if key_pegs.all? { |peg| peg == "kr" }
            puts "Guesser won!"
            return true
        end
        return false
    end

    # Check if the guesser used all of their turns.
    def no_turns?
        if @turns == 0
            puts "Creator won!"
            return true
        end
        return false
    end

    # Generate a random code for the user to guess.
    def generate_code 
        return (0..3).map { ['r','b','g','y','m','c'].to_a[rand(6)] }.join
    end

    # Generate a guess.
    # Right now, the method filters out codes that would produce the same result or with less red pegs,
    # then it picks from the remaining possibilities.
    def generate_guess(key_pegs)
        if @turns == 12
            return "rrbb"
        else
            puts @S.length
            @S = @S.reject { |code| key_pegs == get_key_pegs(code) || get_key_pegs(code).count("kr") < key_pegs.count("kr") }
            return (0..3).map { @S[rand(@S.length)] }.join
        end
    end

    # Check if a code if valid
    def valid_code?(code) 
        return code.length == 4 && /^[rgbymc]+$/.match(code)
    end

    # Runs the session of the where the user is the guesser, so they input 
    # their guesses and try to get the guess correct within 12 turns.
    def guesser_session
        @code = generate_code

        loop do
            puts "Guess the code:"
            guess = gets.chomp

            # Loop until the user types in a valid guess.
            until self.valid_code?(guess) do
                puts "Guess the code:"
                guess = gets.chomp.downcase
            end

            guess_list = guess.split("")
            @turns -= 1

            key_pegs = get_key_pegs(guess_list)
            self.print(guess_list, key_pegs)

            break if self.is_right?(key_pegs) || self.no_turns?
        end
    end

    # Runs the session where the user is the creator, so the computer
    # guesses the user's code.
    def creator_session
        @S = ['r','g', 'b','y','m','c'].to_a.repeated_permutation(4).to_a # Generate all possible code combinations

        puts "Type in a code:"
        @code = gets.chomp.downcase

        # Loop until the user enters a valid code.
        until valid_code?(@code) do
            puts "Type in a code:"
            @code = gets.chomp.downcase
        end

        key_pegs = []
        loop do
            guess = self.generate_guess(key_pegs)
            guess_list = guess.split("")
            @turns -= 1

            key_pegs = get_key_pegs(guess_list)
            self.print(guess_list, key_pegs)

            break if self.is_right?(key_pegs) || self.no_turns?
        end
    end
    
    # Start the game.
    def start
        puts "Guesser or Creator? (Type in guesser or creator)"
        type = gets.chomp.downcase

        # Loop until the user chooses a valid type.
        until type == "guesser" || type == "creator" do
            puts "Guesser or Creator?"
            type = gets.chomp.downcase
        end

        # Notice to the user on how the codes are formatted and how the game works.
        puts "The game accepts 6 colors: r (red), g (green), b (blue), y (yellow), m (magenta), and c (cyan).".green
        puts "The code should be formatted without spaces (Ex. rgby).\n".green
        puts "After you guess, 4 blocks will appear visually showing the layout of your guess.".green
        puts "To the right of these blocks there are 0-4 little pegs shown as an \"O\".".green
        puts "These pegs give hints to the correctness of your guess.".green
        puts "A red peg shows that one of your blocks are correct in color and position.".green
        puts "A grey peg only shows a correct color.".green
        puts "You only have 12 tries. Good luck!\n".green


        if type == "guesser"
            self.guesser_session
        else
            self.creator_session
        end
    end

    # Get key_pegs based off of the guess.
    # A red key peg (kr) corresponds to a code peg that was correct in color and position.
    # A grey key peg (kg) corresponds to a code peg that was correct in only color.
    def get_key_pegs(guess_list)
        key_pegs = [" ", " ", " ", " "]
        checked_pegs = []
        peg_idx = 0

        guess_list.each_with_index do |code_peg, index|
            if @code.include?(code_peg) && checked_pegs.count(code_peg) < @code.count(code_peg)
                if (@code[index] == code_peg)
                    key_pegs[peg_idx] = "kr"
                else
                    key_pegs[peg_idx] = "kg"
                end

                checked_pegs.push(code_peg)
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