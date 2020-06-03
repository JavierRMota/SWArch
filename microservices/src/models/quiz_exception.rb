# Final Project: Quiz Application with Microservices
# Date: 09-Jun-2020
# File: quiz_exception.rb
# Authors: A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

# The +QuizException+ class extends from
# ::StandardError class and allows you to create
# Specific exceptions for the ::Quiz class 
class QuizException < StandardError
    # Returns a new Exception object of type ApiException
    # and class QuizException.
    def initialize(msg="API Exception", exception_type="ApiException")
        @exception_type = exception_type
        super(msg)
    end
end

# The +QuizEndedException+ class extends from
# QuizException class and allows you to create
# Specific exceptions for the ::Quiz class 
class QuizEndedException < QuizException
end