# File name: control.rb
# Decorator Pattern
# Date: 20-abr-2020
# Authors:
#          A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

# The source code contained in this file demonstrates how to
# implement the <em>decorator pattern</em>.

#Beverages class
class Beverage
  #Getters and setters for description and cost
  attr_reader :cost, :description

  #Initializes the beverage objects
  def initialize(description, cost)
      @description = description
      @cost = cost
  end
end

#DarkRoast Class. Inherits from Beverages.
class DarkRoast < Beverage
  #Initializes the beverage object with specific attributes
  def initialize()
      super("Dark Roast Coffee", 0.99)
  end
end

#Espresso Class. Inherits from Beverages.
class Espresso < Beverage
  #Initializes the beverage object with specific attributes
  def initialize()
      super("Espresso", 1.99)
  end
end

#HouseBlend Class. Inherits from Beverages.
class HouseBlend < Beverage
  #Initializes the beverage object with specific attributes
  def initialize()
      super("House Blend Coffee", 0.89)
  end
end

#CondimentDecorator Class. Inherits from Beverages.
class CondimentDecorator < Beverage
  #Initializes the CondimentDecorator object.
  def initialize(beverage, cost, description)
      @beverage = beverage
      super(description, cost)
  end
  #Extends the cost of the beverage.
  def cost
    @beverage.cost + @cost
  end

  #Extends the description of the beverage.
  def description
    @beverage.description + ", " +  @description
  end
end

#Soy Class. Inherits from CondimentDecorator.
class Soy < CondimentDecorator
  #Initializes the condimentDecorator object with specific attributes
  def initialize(beverage)
    super(beverage, 0.15, "Soy")
  end
end

#Mocha Class. Inherits from CondimentDecorator.
class Mocha < CondimentDecorator
  #Initializes the condimentDecorator object with specific attributes
  def initialize(beverage)
    super(beverage, 0.20, "Mocha")
  end
end

#Whip Class. Inherits from CondimentDecorator.
class Whip < CondimentDecorator
  #Initializes the condimentDecorator object with specific attributes
  def initialize(beverage)
    super(beverage, 0.10, "Whip")
  end
end

#Milk Class. Inherits from CondimentDecorator.
class Milk < CondimentDecorator
  #Initializes the condimentDecorator object with specific attributes
  def initialize(beverage)
    super(beverage, 0.10, "Milk")
  end
end
