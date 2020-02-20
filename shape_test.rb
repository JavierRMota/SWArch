require 'minitest/autorun'
require './shape'
class ShapeTest < Minitest::Test
  def test_shape
    sh = Shape.new
    assert_raises(RuntimeError) { sh.area }
  end
  def test_circle
    c = Circle.new(5)
    assert_in_delta 78.539, c.area, 0.001
  end
end
