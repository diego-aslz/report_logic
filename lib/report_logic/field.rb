module ReportLogic
  class Field
    attr_accessor :value, :type, :name

    def initialize(name, value=nil, type=nil)
      @name  = name
      @value = value
      @type  = type
    end

    def type
      @type ||= guess_type
    end

    def guess_type
      @value.class
    end
  end
end
