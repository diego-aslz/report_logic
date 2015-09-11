module ReportLogic
  class Field
    attr_reader :type, :config

    def initialize(name, value = nil, **config)
      @name = name
      @value = value
      @type = config.delete :type
      @decorate_name = config.delete :decorate_name
      @decorate_value = config.delete :decorate_value
      @config = config
    end

    def name
      apply_decorators @name, @decorate_name
    end

    def value
      apply_decorators @value, @decorate_value
    end

    def type
      @type ||= guess_type
    end

    def guess_type
      @value.class
    end

    private

    def apply_decorators(str, decorators)
      return str unless decorators
      if decorators.respond_to? :each
        decorators.each do |dec|
          str = dec.call str
        end
        return str
      end
      decorators.call str
    end
  end
end
