module ReportLogic
  class Field
    include Decorable

    attr_accessor :key, :value, :type, :name, :group

    def initialize(name, value=nil, type: nil, key: nil, decorate_with: nil)
      @name  = name
      @value = value
      @type  = type
      @key   = key || (name.is_a?(Symbol) ? name : nil)
      if decorate_with
        if decorate_with.respond_to?(:each)
          decorate_with.each { |dec| decorator dec }
        else
          decorator decorate_with
        end
      end
    end

    def type
      @type ||= guess_type
    end

    def guess_type
      @value.class
    end

    def decorate(master_decorators = nil)
      decorate_with(master_decorators) if master_decorators
      decorate_with(decorators)
    end

    def decorate_with(decorators)
      decorators.each do |dec|
        dec.decorate_if_matches(self)
      end
      self
    end
  end
end
