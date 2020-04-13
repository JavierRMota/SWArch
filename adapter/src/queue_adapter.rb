# Adapter Pattern
# Date: 12-Apr-2020
# Authors:
#          A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

# File: queue_adapter.rb

#A class that adapts a FIFO queue to LIFO queue.
class QueueAdapter

    # Initializes a new stack, using q as the adaptee.
    def initialize(q)
        @queue = q
    end

    # Inserts x at the top of the stack and returns it.
    def push(x)
        @queue.insert(x)
        self
    end

    # If the stack is empty, returns nil, else it removes and returns the top element of the stack.
    def pop
        if @queue.empty?
            nil
        else
            tempArr = []
            while @queue.size > 1
                tempArr.push(@queue.remove)
            end
            tempItem = @queue.remove
            while !tempArr.empty?
                @queue.insert(tempArr.pop)
            end
            tempItem
        end
    end

    # If the stack is empty, returns nil, else it returns the top element without removing it from the stack.
    def peek
        if empty?
            nil
        else
            tempArr = []
            while @queue.size > 1
                tempArr.push(@queue.remove)
            end
            tempItem = @queue.remove
            while !tempArr.empty?
                @queue.insert(tempArr.pop)
            end
            @queue.insert(tempItem)
            tempItem
        end
    end

    # If the stack is empty, returns true, else returns false.
    def empty?
        @queue.empty?
    end

    # Returns the number of elements in the stack.
    def size
        @queue.size
    end
end