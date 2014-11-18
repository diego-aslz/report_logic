module ReportLogic
  module I18nSupport
    def i18n_decorate
      decorators << I18nDecorator.new
    end
  end
end
