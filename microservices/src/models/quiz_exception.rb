class QuizException < StandardError
    def initialize(msg="API Exception", exception_type="ApiException")
        @exception_type = exception_type
        super(msg)
    end
end
class QuizEndedException < QuizException
end