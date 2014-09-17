module ReportLogic
  class Decorator
    attr_accessor :group

    def initialize(group: nil)
      @group = group
    end

    def decorate(field)
      raise NotImplementedError
    end

    def decorate_if_matches(field)
      decorate(field) if matches?(field)
    end

    def matches?(field)
      group.nil? || group == field.group
    end
  end
end
