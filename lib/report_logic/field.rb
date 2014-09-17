module ReportLogic
  class Field
    attr_accessor :key, :value, :type, :name, :group

    def initialize(name, value=nil, type: nil, key: nil, group: nil)
      @name  = name
      @value = value
      @type  = type
      @key   = key || (name.is_a?(Symbol) ? name : nil)
      @group = group
    end

    def type
      @type ||= guess_type
    end

    def guess_type
      @value.class
    end
  end
end
