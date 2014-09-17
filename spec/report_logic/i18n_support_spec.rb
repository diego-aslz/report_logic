require 'spec_helper'
require 'i18n'

describe ReportLogic::I18nSupport do
  let(:report) { MyI18nReport.new }

  let(:headers) { report.each(:header) }

  before(:all) do
    I18n.enforce_available_locales = false
    I18n.backend.store_translations(:es, report: { names: { name: 'Nombre' } })
    I18n.default_locale = :es
  end

  after(:all) do
    I18n.backend = nil
    I18n.default_locale = nil
  end

  it "translates key fields" do
    expect(headers.count    ).to eql(2)
    expect(headers.next.name).to eql('ID')
    expect(headers.next.name).to eql('Nombre')
  end
end
