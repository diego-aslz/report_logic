module ReportLogic
  class Decorator
    attr_accessor :key

    def initialize(key: nil)
      @key = key
    end

    def decorate(field)
      decorate_name(field)
      decorate_value(field)
    end

    def decorate_name(field); end

    def decorate_value(field); end

    def decorate_if_matches(field)
      decorate(field) if matches?(field)
    end

    def matches?(field)
      key.nil? || key == field.key || Array === key && key.include?(field.key)
    end
  end
end
