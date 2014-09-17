module ReportLogic
  class Field
    attr_accessor :key, :value, :type, :name

    def initialize(name, value=nil, type: nil, key: nil)
      @name  = name
      @value = value
      @type  = type
      @key   = key || (name.is_a?(Symbol) ? name : nil)
    end

    def type
      @type ||= guess_type
    end

    def guess_type
      @value.class
    end
  end
end
