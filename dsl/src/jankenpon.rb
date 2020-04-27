# File name: jankenpon.rb
# Domain-Specific Language Pattern
# Date: 27-abr-2020
# Authors:
#          A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

#Class Jankenpon - Rock, Paper, Scissors, Lizard and Spock Game
class Jankenpon
  #Getters and setters
  def winner
    self.class.name
  end
end

#Class Lizard - Describes moves for the DSL
class Lizard < Jankenpon

  # Returns the winner between Lizard and rival
  def + rival
    case rival
    when Lizard
      puts 'Lizard tie (winner Lizard)'
    when Paper
      puts 'Lizard eats Paper (winner Lizard)'
    when Spock
      puts 'Lizard poisons Spock (winner Lizard)'
    else
      return rival + self
    end
    Lizard
  end

  # Returns the loser between Lizard and rival
  def - rival
    case rival
    when Lizard
      puts 'Lizard tie (loser Lizard)'
    when Scissors
      puts 'Scissors decapitate Lizard (loser Lizard)'
    when Rock
      puts 'Rock crushes Lizard (loser Lizard)'
    else
      return rival - self
    end
    Lizard
  end
end

#Class Spock - Describes moves for the DSL
class Spock < Jankenpon

  # Returns the winner between Spock and rival
  def + rival
    case rival
    when Rock
      puts 'Spock vaporizes Rock (winner Spock)'
    when Scissors
      puts 'Spock smashes Scissors (winner Spock)'
    when Spock
      puts 'Spock tie (winner Spock)'
    else
      return rival + self
    end
    Spock
  end

  # Returns the loser between Spock and rival
  def - rival
    case rival
    when Lizard
      puts 'Lizard poisons Spock (loser Spock)'
    when Paper
      puts 'Paper disproves Spock (loser Spock)'
    when Spock
      puts 'Spock tie (loser Spock)'
    else
      return rival - self
    end
    Spock
  end
end

#Class Paper - Describes moves for the DSL
class Paper < Jankenpon

  # Returns the winner between Paper and rival
  def + rival
    case rival
    when Rock
      puts 'Paper covers Rock (winner Paper)'
    when Spock
      puts 'Paper disproves Spock (winner Paper)'
    when Paper
      puts 'Paper tie (winner Paper)'
    else
      return rival + self
    end
    Paper
  end

  # Returns the loser between Paper and rival
  def - rival
    case rival
    when Paper
      puts 'Paper tie (loser Paper)'
    when Scissors
      puts 'Scissors cut Paper (loser Paper)'
    when Lizard
      puts 'Lizard eats Paper (loser Paper)'
    else
      return rival - self
    end
    Paper
  end
end

#Class Rock - Describes moves for the DSL
class Rock < Jankenpon

  # Returns the winner between Rock and rival
  def + rival
    case rival
    when Lizard
      puts 'Rock crushes Lizard (winner Rock)'
    when Scissors
      puts 'Rock crushes Scissors (winner Rock)'
    when Rock
      puts 'Rock tie (winner Rock)'
    else
      return rival + self
    end
    Rock
  end

  # Returns the loser between Rock and rival
  def - rival
    case rival
    when Rock
      puts 'Rock tie (loser Rock)'
    when Paper
      puts 'Paper covers Rock (loser Rock)'
    when Spock
      puts 'Spock vaporizes Rock (loser Rock)'
    else
      return rival - self
    end
    Rock
  end
end

#Class Scissors - Describes moves for the DSL
class Scissors < Jankenpon

  # Returns the winner between Scissors and rival
  def + rival
    case rival
    when Lizard
      puts 'Scissors decapitate Lizard (winner Scissors)'
    when Paper
      puts 'Scissors cut Paper (winner Scissors)'
    when Scissors
      puts 'Scissors tie (winner Scissors)'
    else
      return rival + self
    end
    Scissors
  end

  # Returns the loser between Scissors and rival
  def - rival
    case rival
    when Scissors
      puts 'Scissors tie (loser Scissors)'
    when Rock
      puts 'Rock crushes Scissors (loser Scissors)'
    when Spock
      puts 'Spock smashes Scissors (loser Scissors)'
    else
      return rival - self
    end
    Scissors
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
