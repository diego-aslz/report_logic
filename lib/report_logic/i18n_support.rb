require 'i18n'

module ReportLogic
  module I18nSupport
    class I18nDecorator < Decorator
      include I18nHelper

      def decorate(field)
        field.name = i18n_lookup(:names, field.name) if Symbol === field.name
      end
    end

    def i18n_decorate(**options)
      decorators << I18nDecorator.new(**options)
    end
  end
end
