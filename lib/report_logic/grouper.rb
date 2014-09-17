module ReportLogic
  class Grouper
    def initialize(record = nil, &block)
      instance_exec record, &block if block
    end

    def result
      @result ||= []
    end

    def field(name, value = nil, **options)
      result << Field.new(name, value, **options)
    end

    def value(val)
      result << Field.new(nil, val)
    end
  end
end
