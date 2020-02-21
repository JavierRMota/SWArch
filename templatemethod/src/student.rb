# Template Method Pattern
# Date: 18-Feb-2020
# Authors:
#          A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

#Student class
class Student

  include Enumerable
  # Note: This class does not support the max, min,
  # or sort methods.

  #Creates a new instance of a Student
  def initialize(id, name, grades)
    @id = id
    @name = name
    @grades = grades
  end

  #Inspects an instance of a Student. It shows id and name.
  def inspect
    "Student(#{@id}, #{@name.inspect})"
  end

  #Gets the grades' average of a Student
  def grade_average
    @grades.inject(:+)/@grades.size
  end

  #Yields the id, name and grades.
  def each &block
    yield @id
    yield @name
    @grades.each(&block)
    yield grade_average
  end

end