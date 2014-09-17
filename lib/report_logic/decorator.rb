module ReportLogic
  class Decorator
    attr_accessor :key, :group

    def initialize(group: nil, key: nil)
      @group = group
      @key   = key
    end

    def decorate(field)
      raise NotImplementedError
    end

    def decorate_if_matches(field)
      decorate(field) if matches?(field)
    end

    def matches?(field)
      (key.nil? || key == field.key) &&
        (group.nil? || group == field.group)
    end
  end
end
