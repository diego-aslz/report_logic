module ReportLogic
  class I18nDecorator < Decorator
    include I18nHelper

    def decorate(field)
      field.name = i18n_lookup(:names, field.name) if Symbol === field.name
    end
  end
end
