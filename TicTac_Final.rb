class TicTacToe

  def initialize
    @board = { a1: "", a2: "", a3: "",
               b1: "", b2: "", b3: "",
               c1: "", c2: "", c3: "" }
    @player_name_1 = ""
    @player_name_2 = ""
    @player_data = {}
  end

  def welcome
    puts "What is your name, Player 1?"
    @player_name_1 = gets.chomp.capitalize
    puts "\nWelcome #{@player_name_1}!"
    puts "\nWhat is your name, Player 2?"
    @player_name_2 = gets.chomp.capitalize
    puts "\nWelcome #{@player_name_2}!"
    player_start
  end

  def player_start
    random = rand
      if random < 0.5
        puts "\n#{@player_name_1}, you are X, please move first! #{@player_name_2}, you are O, please move second."
          @player_data[@player_name_1] = "X"
          @player_data[@player_name_2] = "O"
      else
        puts "\n#{@player_name_2}, you are X, please move first! #{@player_name_1}, you are O, please move second."
          @player_data[@player_name_1] = "O"
          @player_data[@player_name_2] = "X" #By storing X and O into the values for each player name key, I allow the program to later accurately check to see which player name won by matching the player_symbol argument at time of win to the corresponding value in the player_data hash here.
      end
    puts "\nPlease refer to the game board below for the tic tac toe game spaces. a1 is the upper left corner space, b2 is the center space, etc. Enter a game space like so\n\na1\n\nto move."  
    move_intro("X") #Game always starts with X, so we pass this argument to the move_intro method to start the game.
  end

  def move_intro(player_symbol)
    if @player_data[@player_name_1] == player_symbol
      puts "\n#{@player_name_1}, please enter your move."
      move(player_symbol)
    else
      puts "\n#{@player_name_2}, please enter your move."
      move(player_symbol)
    end
  end

  def move(player_symbol)
    print_board #see method below
    player_input = gets.chomp.downcase.to_sym
      if @board.has_key?(player_input) == true #Checks to see if player inputted a string equal to a key (or game space) in the game board hash.
        if @board[player_input] != "" #If player inputs a game space which does not have an undefined ("") value, then that space must have been moved to already.  
          move_taken(player_symbol)
        else 
          @board[player_input] = player_symbol #This assigns the appropriate player_symbol as the value of the game space key the player inputted.
          outcome_check(player_symbol)    
        end
      else 
        invalid_move(player_symbol)
      end    
  end

  def outcome_check(player_symbol)
    winning_combos = @board.values.to_a #We will be using the winning_combos array to check for winning tic tac toe moves, looking only at the values from the original board hash, shrinking it to an object with 9 elements (or 8 indices). Because the array is ordered, we can examine it for winning combinations of X's or O's by grouping and comparing the elements at the appropriate indices of the array. The eight groups of winning indices, or tic tac toe moves, would be [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
      unless ([winning_combos[0], winning_combos[1], winning_combos[2]].uniq.length == 1 && winning_combos[0] != "") || ([winning_combos[3], winning_combos[4], winning_combos[5]].uniq.length == 1 && winning_combos[3] != "") || ([winning_combos[6], winning_combos[7], winning_combos[8]].uniq.length == 1 && winning_combos[6] != "") || ([winning_combos[0], winning_combos[3], winning_combos[6]].uniq.length == 1 && winning_combos[0] != "") || ([winning_combos[1], winning_combos[4], winning_combos[7]].uniq.length == 1 && winning_combos[1] != "") || ([winning_combos[2], winning_combos[5], winning_combos[8]].uniq.length == 1 && winning_combos[2] != "") || ([winning_combos[0], winning_combos[4], winning_combos[8]].uniq.length == 1 && winning_combos[0] != "") || ([winning_combos[2], winning_combos[4], winning_combos[6]].uniq.length == 1 && winning_combos[2] != "")
        #This statement checks for the length of the number of unique elements in the eight arrays above. If all elements in one of the eight arrays above are the same AND all those elements are NOT blank ("") - since we don't want false wins because of 3 equal empty spaces - then there will be only one unique element in that particular array, yielding an array length of 1. This signifies a win, and the method will move to the "else" section of the Unless/Else statement, and tell us who won the game!
          if winning_combos.any? {|x| x == ""} == false #If no one has won and there are no blank spaces left on the board, the game is a tie.
            puts "\nThe game is a tie!" 
            play_again  
          else #If no one has won but there are blank spaces left, the game proceeds. The player_symbol argument will change from X to O or O to X to ensure the moves continue shifting back and forth between the players.
            if player_symbol == "X"
              player_symbol = "O"
              move_intro(player_symbol)
            elsif player_symbol == "O"
              player_symbol = "X"
              move_intro(player_symbol)
            end
          end 
      else
        if player_symbol == @player_data[@player_name_1]
          puts "\n#{@player_name_1} has won the game!"
          play_again
        else
          puts "\n#{@player_name_2} has won the game!"
          play_again
        end
      end
  end

  def print_board #I created this method to design a more aesthetic board than just displaying the board hash. I think the way it displays and runs in Ruby is much more user-friendly now.
    puts " --- --- ---\n"
    @board.each do |space, letter|
      case 
      when space == :a1
        if letter == ""
          print "|#{space} |"
        else  
          print "| #{letter} |"
        end
      when space == :a2 
        if letter == ""
          print "#{space} |"
        else
          print " #{letter} |"
        end
      when space == :a3
        if letter == ""
          print "#{space} |\n --- --- --- \n"
        else
          print " #{letter} |\n --- --- --- \n"
        end   
      when space == :b1
        if letter == ""
          print "|#{space} |"
        else  
          print "| #{letter} |"
        end
      when space == :b2 
        if letter == ""
          print "#{space} |"
        else
          print " #{letter} |"
        end
      when space == :b3
        if letter == ""
          print "#{space} |\n --- --- ---\n"
        else
          print " #{letter} |\n --- --- ---\n"
        end
      when space == :c1
        if letter == ""
          print "|#{space} |"
        else  
          print "| #{letter} |"
        end
      when space == :c2 
        if letter == ""
          print "#{space} |"
        else
          print " #{letter} |"
        end
      when space == :c3
        if letter == ""
          print "#{space} |\n --- --- ---\n"
        else
          print " #{letter} |\n --- --- ---\n"
        end
      end
    end
  end

  def move_taken(player_symbol)
    puts "\nSorry! That space is already taken. Please enter a different space."
    move(player_symbol)
  end 

  def invalid_move(player_symbol)
    puts "\nError! That space does not exist. Please enter a space like so: a1, b1, c1, etc."
    move(player_symbol)
  end

  def play_again
    puts "\nWould you like to play again? (Please type \"yes\" or \"no\")"
    play_again = gets.chomp.downcase
      if play_again == "yes"
        @player_data.clear
        @board = { a1: "", a2: "", a3: "",
                   b1: "", b2: "", b3: "",
                   c1: "", c2: "", c3: "" }
        welcome
      else
        puts "\nThanks for playing, #{@player_name_1} and #{@player_name_2}!"
      end
  end 

end 

game = TicTacToe.new
game.welcome

