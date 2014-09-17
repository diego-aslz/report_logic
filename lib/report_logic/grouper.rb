module ReportLogic
  class Grouper
    def initialize(record = nil, &block)
      instance_exec record, &block
    end

    def result
      @result ||= []
    end

    def field(name)
      result << Field.new(name)
    end

    def value(val)
      result << Field.new(nil, val)
    end
  end
end
