# File name: simple_queue.rb
# Adapter Pattern
# Date: 13-abr-2020
# Authors:
#          A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

# File: simple_queue.rb

# IMPORTANT: Do not modify the following class in any way!

class SimpleQueue

  def initialize
    @info =[]
  end

  def insert(x)
    @info.push(x)
    self
  end

  def remove
    if empty?
      raise "Can't remove if queue is empty"
    else
      @info.shift
    end
  end

  def empty?
    @info.empty?
  end

  def size
    @info.size
  end

  def inspect
    @info.inspect
  end

end
