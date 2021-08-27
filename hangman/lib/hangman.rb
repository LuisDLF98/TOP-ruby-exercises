require 'yaml'

$save = ""

class Hangman
    attr_accessor :word, :tries, :display, :user

    def initialize(word, tries, display, user)
        @word = word
        @tries_left = tries
        @display = display
        @user = user
    end

    def to_yaml
        YAML.dump({
            :word => @word.to_s,
            :tries => @tries_left.to_i,
            :display => @display.to_s,
            :user => @user.to_s
        })
    end

    def self.from_yaml(string)
        data = YAML.load(File.read(string))
        
        self.new(data[:word], data[:tries], data[:display], data[:user])
    end

    # Save progress
    def save
        file_name = "saves/#{@user}.yml"
        File.open(file_name, 'w') { |file| file.write(self.to_yaml) }
    end

    # Chooses a word between 5-12 characters long.
    def self.pick_word
        word = ""
        until (5..12).include?(word.length)
            word = File.readlines("5desk.txt").sample.strip
        end
        word
    end

    # Add the guessed letter to the display whereever it shows up in the word.
    def add_letter(letter)
        char_list = @word.split("")

        char_list.each_with_index do |character, index|
            if letter == character
                @display[index] = letter
            end
        end
    end

    # Check if the player won the game.
    # If the player won, then it deletes the save file if it exists
    def is_win?
        if @word.eql?(@display)
            puts "Player won!"
            File.delete("saves/#{@user}.yml") if File.exist?("saves/#{@user}.yml")
            true
        else
            false
        end
    end

    # Check if the player ran out of guesses.
    # If the player won, then it deletes the save file if it exists
    def out_of_tries?
        if @tries_left < 1
            puts "Player lost!"
            File.delete("saves/#{@user}.yml") if File.exist?("saves/#{@user}.yml")
            true
        else 
            false
        end
    end

    def start
        loop do
            puts "#{@display} | #{@tries_left} tries left"

            puts "Choose a letter:"
            letter = gets.chomp.downcase

            # Check input for a single alphebetical letter, or "save"
            until letter.eql?("save") || /^[a-z]$/.match(letter)

                puts "Choose a letter:"
                letter = gets.chomp.downcase
            end

            if letter.eql?("save")
                self.save
                return
            elsif @word.include?(letter)
                add_letter(letter)
            else
                @tries_left -= 1
            end

            break if self.is_win? || self.out_of_tries?
        end
    end
end

input = ""
game = nil

loop do
    puts "Start new game or continue? (Type \"start\" to start new, or type \"continue\" to continue.)"
    input = gets.chomp.downcase.strip

    if input.eql?("start")
        # Create a new game

        word = Hangman.pick_word
        tries = word.length
        display = "".rjust(word.length, "-")

        puts "Enter a username"
        user = gets.chomp

        game = Hangman.new(word,tries, display, user)
        game.start

    elsif input.eql?("continue")
        # Load up a saved game

        users = Dir.glob(File.join("**", "*.yml")) # Grab yaml file names
        users.map! { |file| Hangman.from_yaml(file) } # Map to the Hangman objects

        puts "Select user (type in the save #):"
        users.each_with_index { |file, index| puts "Save #{index + 1}: #{file.user.to_s} " } # List saves
        user = gets.chomp.strip

        # Wait for the user to input a valid save #
        until /^([1..9])$/.match(user) && (1..10).include?(users.length) do
            puts "Select user (type in the save #):"
            users.each_with_index { |file, index| puts "Save #{index + 1}: #{file.user.to_s} " }
            user = gets.chomp
        end

        # Load up the game
        users[user.to_i - 1].start
    end
end