module ReportLogic
  class Decorator
    def decorate(field)
      raise NotImplementedError
    end

    def decorate_if_matches(field)
      decorate(field)
    end
  end
end
