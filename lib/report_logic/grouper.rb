module ReportLogic
  class Grouper
    attr_accessor :group

    def initialize(record = nil, group: nil, &block)
      @group = group
      instance_exec record, &block if block
    end

    def result
      @result ||= []
    end

    def field(name, value = nil, **options)
      result << Field.new(name, value, group: group, **options)
    end

    def value(val, **options)
      field(nil, val, **options)
    end
  end
end
