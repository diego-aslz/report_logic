module ReportLogic
  module I18nSupport
    def i18n_decorate
      decorate_with I18nDecorator.new
    end
  end
end
