# File name: queue_adapter.rb
# Adapter Pattern
# Date: 13-abr-2020
# Authors:
#          A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

#A class that adapts a FIFO queue to LIFO queue.
class QueueAdapter

  # Initializes a new stack, using q as the adaptee.
  def initialize(q)
    @q = q
  end

  # Utility method to insert x at the top of the stack.
  def push_util(x)
    queue_array = []
    while !empty?
      queue_array.push(pop)
    end
    @q.insert(x)
    while !queue_array.empty?
      @q.insert(queue_array.shift)
    end
  end

  # Inserts x at the top of the stack and returns itself.
  def push(x)
    push_util(x)
    self
  end

  # Removes and returns the top element of the stack, returns nil if it is empty
  def pop
    if empty?
      nil
    else
      @q.remove
    end
  end

  # If the stack is empty returns true, else false
  def empty?
    @q.empty?
  end

  # Returns the number of elements in the stack
  def size
    @q.size
  end

  # Returns the top element of the stack without removing it, returns nil if it is empty
  def peek
    if empty?
      nil
    else
      x = pop
      push_util(x)
      x
    end
  end

end
