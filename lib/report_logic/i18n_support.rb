require 'i18n'

module ReportLogic
  module I18nSupport
    class I18nDecorator
      include I18nHelper

      def decorate(field)
        field.name = i18n_lookup(:names, field.name) if Symbol === field.name
      end
    end

    def i18n_decorate(group = nil)
      add_decorator group, I18nDecorator.new
    end
  end
end
