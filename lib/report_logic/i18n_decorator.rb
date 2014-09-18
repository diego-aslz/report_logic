module ReportLogic
  class I18nDecorator < Decorator
    include I18nHelper

    def decorate_name(field, name=field.name, **options)
      field.name  = i18n_lookup(:names , name, **options) if Symbol === name
    end

    def decorate_value(field, value=field.value, **options)
      field.value  = i18n_lookup(:values , value, **options) if Symbol === value
    end
  end
end
