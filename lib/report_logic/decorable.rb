module ReportLogic
  module Decorable
    def decorators
      @decorators ||= []
    end

    def decorate_with(dec)
      if dec
        if dec.respond_to?(:each)
          dec.each { |dec| decorators << dec }
        else
          decorators << dec
        end
      end
    end
  end
end
