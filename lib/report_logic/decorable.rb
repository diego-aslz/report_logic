module ReportLogic
  module Decorable
    def decorators
      @decorators ||= []
    end

    def decorator(dec)
      decorators << dec
    end
  end
end
