module ReportLogic
  module I18nSupport
    def i18n_decorate(**options)
      decorators << I18nDecorator.new(**options)
    end
  end
end
