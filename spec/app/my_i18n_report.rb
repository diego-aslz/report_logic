class MyI18nReport < ReportLogic::Base
  include ReportLogic::I18nSupport

  def build
    i18n_decorate

    session(:header) do
      field 'ID'
      field :name
    end
  end
end
