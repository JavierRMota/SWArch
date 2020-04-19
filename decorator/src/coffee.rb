# Decorator Pattern
# Date: 18-Apr-2020
# Authors:
#          A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

# File: coffee.rb

#Beverages class
class Beverages
    #Getters and setters for description and cost
    attr_accessor :description, :cost

    #Initializes the beverage objects
    def initialize
        @description = ''
        @cost = 0
    end

end

#DarkRoast Class. Inherits from Beverages.
class DarkRoast < Beverages

    #Updates the description of the beverage
    def description
        @description << 'Dark Roast Coffee'
    end

    #Sum the cost of a Dark Roast Coffee Beverage
    def cost
        @cost += 0.99
    end
end

#Espresso Class. Inherits from Beverages.
class Espresso < Beverages

    #Updates the description of the beverage
    def description
        @description << 'Espresso'
    end

    #Sum the cost of a Espresso Beverage
    def cost
        @cost += 1.99
    end

end

#HouseBlend Class. Inherits from Beverages.
class HouseBlend < Beverages
    #Updates the description of the beverage
    def description
        @description << 'House Blend Coffee'
    end

    #Sum the cost of a House Blend Coffee Beverage
    def cost
        @cost += 0.89
    end
end

#CondimentDecorator Class. Inherits from Beverages
class CondimentDecorator < Beverages

    #Initializes the CondimentDecorator. Reassigns the beverage to the CondimentDecorator
    def initialize(beverage)
        @beverage = beverage
    end
end

#Mocha Class. Inherits from CondimentDecorator.
class Mocha < CondimentDecorator

    #Updates the description of the beverage
    def description
        @beverage.description << ", Mocha"
    end

    #Increase the cost of the beverage
    def cost
        @beverage.cost += 0.20
    end

end

#Whip Class. Inherits from CondimentDecorator.
class Whip < CondimentDecorator

    #Updates the description of the beverage
    def description
        @beverage.description << ", Whip"
    end

    #Increase the cost of the beverage
    def cost
        @beverage.cost += 0.10
    end
end

#Soy Class. Inheris from CondimentDecorator.
class Soy < CondimentDecorator

    #Updates the description of the beverage.
    def description
        @beverage.description << ", Soy"
    end

    #Increase the cost of the beverage.
    def cost
        @beverage.cost += 0.15
    end
end

#Milk Class. Inherits from CondimentDecorator.
class Milk < CondimentDecorator
    #Updates the description of the beverage.
    def description
        @beverage.description << ", Milk"
    end

    #Increase the cost of the beverage.
    def cost
        @beverage.cost += 0.10
    end
end