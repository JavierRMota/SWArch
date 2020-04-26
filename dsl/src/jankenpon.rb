# Domain-Specific Language Pattern
# Date: 25-Apr-2020
# Authors:
#          A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

# File: jankenpon.rb

#Class Jankenpon - Rock, Paper, Scissors, Lizard and Spock Game
class Jankenpon
    #Getters and setters
    attr_accessor :winner

    #Returns the winner
    def result(winner)
        "Result = " + winner
    end

end

#Class Lizard - Describes moves for the DSL
class Lizard < Jankenpon
    #Creates a new Lizard and assigns @winner to Lizard
    def initialize
        @winner = 'Lizard'
    end

    #Returns the winner
    def result
        super(@winner)
    end

    # Returns the winner between Lizard and rival
    def +(rival)
        if rival == Spock
            puts 'Lizard poisons Spock (winner Lizard)'
        elsif rival == Paper
            puts 'Lizard eats Paper (winner Lizard)'
        elsif rival != self
            return rival + self
        else
            puts 'Lizard tie (winner Lizard)'
        end
        Lizard
    end

    # Returns the loser between Lizard and rival
    def -(rival)
        if rival == Rock
            puts 'Rock crushes Lizard (loser Lizard)'
        elsif rival == Scissors
            puts 'Scissors decapitate Lizard (loser Lizard)'
        elsif rival != self
            return rival - self
        else
            puts 'Lizard tie (loser Lizard)'
        end
        Lizard
    end

end

#Class Spock - Describes moves for the DSL
class Spock < Jankenpon
    #Creates a new Spock and assigns @winner to Spock
    def initialize
        @winner = 'Spock'
    end

    #Returns the winner
    def result
        super(@winner)
    end

    # Returns the winner between Spock and rival
    def +(rival)
        if rival == Rock
            puts 'Spock vaporizes Rock (winner Spock)'
        elsif rival == Scissors
            puts 'Spock smashes Scissors (winner Spock)'
        elsif rival != self
            return rival + self
        else
            puts 'Spock tie (winner Spock)'
        end
        Spock
    end

    # Returns the loser between Spock and rival
    def -(rival)
        if rival == Lizard
            puts 'Lizard poisons Spock (loser Spock)'
        elsif rival == Paper
            puts 'Paper disproves Spock (loser Spock)'
        elsif rival != self
            return rival - self
        else
            puts 'Spock tie (loser Spock)'
        end
        Spock
    end

end

#Class Rock - Describes moves for the DSL
class Rock < Jankenpon
    #Creates a new Rock and assigns @winner to Rock
    def initialize
        @winner = 'Rock'
    end

    #Returns the winner
    def result
        super(@winner)
    end

    # Returns the winner between Rock and rival
    def +(rival)
        if rival == Lizard
            puts 'Rock crushes Lizard (winner Rock)'
        elsif rival == Scissors
            puts 'Rock crushes Scissors (winner Rock)'
        elsif rival != self
            return rival + self
        else
            puts 'Rock tie (winner Rock)'
        end
        Rock
    end

    # Returns the loser between Rock and rival
    def -(rival)
        if rival == Spock
            puts 'Spock vaporizes Rock (loser Rock)'
        elsif  rival == Paper
            puts 'Paper covers Rock (loser Rock)'
        elsif rival != self
            return rival - self
        else
            puts 'Rock tie (loser Rock)'
        end
        Rock
    end

end

#Class Scissors - Describes moves for the DSL
class Scissors < Jankenpon
    #Creates a new Scissor and assigns @winner to Scissors
    def initialize
        @winner = 'Scissor'
    end

    #Returns the winner
    def result
        super(@winner)
    end

    # Returns the winner between Scissors and rival
    def +(rival)
        if rival == Paper
            puts 'Scissors cut Paper (winner Scissors)'
        elsif rival == Lizard
            puts 'Scissors decapitate Lizard (winner Scissors)'
        elsif rival != self
            return rival + self
        else
            puts 'Scissors tie (winner Scissors)'
        end
        Scissors
    end

    # Returns the loser between Scissors and rival
    def -(rival)
        if rival == Spock
            puts 'Spock smashes Scissors (loser Scissors)'
        elsif  rival == Rock
            puts 'Rock crushes Scissors (loser Scissors)'
        elsif rival != self
            return rival - self
        else
            puts 'Rock tie (loser Rock)'
        end
        Scissors
    end

end

#Class Paper - Describes moves for the DSL
class Paper < Jankenpon
    #Creates a new Paper and assigns @winner to Paper
    def initialize
        @winner = 'Paper'
    end

    #Returns the winner
    def result
        super(@winner)
    end

    # Returns the winner between Paper and rival
    def +(rival)
        if rival == Rock
            puts 'Paper covers Rock (winner Paper)'
        elsif rival == Spock
            puts 'Paper disproves Spock (winner Paper)'
        elsif rival != self
            return rival + self
        else
            puts 'Paper tie (winner Paper)'
        end
        Paper
    end

    # Returns the loser between Paper and rival
    def -(rival)
        if rival == Lizard
            puts 'Lizard eats Paper (loser Paper)'
        elsif  rival == Scissors
            puts 'Scissors cut Paper (loser Paper)'
        elsif rival != self
            return rival - self
        else
            puts 'Paper tie (loser Paper)'
        end
        Paper
    end
end

#Returns the winner
def show(move)
    puts "Result = " + move.winner
end

#Initilizes Values
#Spock Constant
Spock = Spock.new
#Lizard Constant
Lizard = Lizard.new
#Rock Constant
Rock = Rock.new
#Scissors Constant
Scissors = Scissors.new
#Paper Constant
Paper = Paper.new