# File name: queue_adapter.rb
# Adapter Pattern
# Date: 13-abr-2020
# Authors:
#          A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López


class QueueAdapter

  def initialize(q)
    @q = q
  end

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

  def push(x)
    push_util(x)
    self
  end

  def pop
    if empty?
      nil
    else
      @q.remove
    end
  end

  def empty?
    @q.empty?
  end

  def size
    @q.size
  end

  def peek
    x = pop
    push_util(x)
    x
  end

end
