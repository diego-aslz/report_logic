module ReportLogic
  class I18nDecorator < Decorator
    include I18nHelper

    def decorate_name(field, name=field.name)
      field.name  = i18n_lookup(:names ,  name) if Symbol === name
    end

    def decorate_value(field, value=field.value)
      field.value  = i18n_lookup(:names ,  value) if Symbol === value
    end
  end
end
