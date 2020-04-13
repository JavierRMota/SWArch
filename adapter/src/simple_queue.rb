# Adapter Pattern
# Date: 12-Apr-2020
# Authors:
#          A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

# File: simple_queue.rb

# IMPORTANT: Do not modify the following class in any way!

#A class that implements a simple queue.
class SimpleQueue

  # Initializes a new stack of SimpleQueue.
  def initialize
    @info =[]
  end

  # Inserts x at the back of this queue and returns the queue.
  def insert(x)
    @info.push(x)
    self
  end

  # Removes and returns the element at the front of the queue.
  # Raises an exception if the queue is empty.
  def remove
    if empty?
      raise "Can't remove if queue is empty"
    else
      @info.shift
    end
  end

  # If the queue is empty, returns true, else returns false.
  def empty?
    @info.empty?
  end

  # Returns the number of elements in the queue.
  def size
    @info.size
  end

  # Creates a string representation of a SimpleQueue instance.
  def inspect
    @info.inspect
  end

end