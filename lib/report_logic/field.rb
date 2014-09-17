module ReportLogic
  class Field
    include Decorable

    attr_accessor :key, :value, :type, :name

    def initialize(name, value=nil, type: nil, key: nil, decorate_with: nil)
      @name  = name
      @value = value
      @type  = type
      @key   = key || (name.is_a?(Symbol) ? name : nil)
      self.decorate_with(decorate_with)
    end

    def type
      @type ||= guess_type
    end

    def guess_type
      @value.class
    end

    def decorate(master_decorators = nil)
      apply_decorators(master_decorators) if master_decorators
      apply_decorators(decorators)
    end

    def apply_decorators(decorators)
      decorators.each do |dec|
        dec.decorate_if_matches(self)
      end
      self
    end
  end
end
