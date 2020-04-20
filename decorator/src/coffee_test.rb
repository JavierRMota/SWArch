# File name: control.rb
# Decorator Pattern
# Date: 20-abr-2020
# Authors:
#          A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

# File: coffee_test.rb

require 'minitest/autorun'
require './coffee'

# The source code contained in this file test the
# implementation of the <em>Decorator Pattern</em>.
class CoffeeTest < Minitest::Test

  #Test the initialization of an espresso.
  def test_espresso
    beverage = Espresso.new
    assert_equal("Espresso", beverage.description)
    assert_equal(1.99, beverage.cost)
  end


  #Test the initialization of a Dark Roast coffee with condiments.
  def test_dark_roast
    beverage = DarkRoast.new
    beverage = Milk.new(beverage)
    beverage = Mocha.new(beverage)
    beverage = Mocha.new(beverage)
    beverage = Whip.new(beverage)
    assert_equal("Dark Roast Coffee, Milk, Mocha, Mocha, Whip",
                 beverage.description)
    assert_equal(1.59, beverage.cost)
  end

  #Test the initialization of a House Blend coffee with condiments.
  def test_house_blend
    beverage = HouseBlend.new
    beverage = Soy.new(beverage)
    beverage = Mocha.new(beverage)
    beverage = Whip.new(beverage)
    assert_equal("House Blend Coffee, Soy, Mocha, Whip",
                 beverage.description)
    assert_equal(1.34, beverage.cost)
  end

end
