require 'spec_helper'
require 'i18n'

describe ReportLogic::I18nSupport do
  let(:report) { MyI18nReport.new }

  let(:headers) { report.each(:header).to_a }

  before(:all) do
    I18n.enforce_available_locales = false
    I18n.backend.store_translations(:es, report: { names: { name: 'Nombre' },
      values: { test: 'This is translated too' } })
    I18n.default_locale = :es
  end

  after(:all) do
    I18n.backend = nil
    I18n.default_locale = nil
  end

  it "translates key fields" do
    expect(headers.size      ).to eql(2)
    expect(headers.first.name).to eql('ID')
    expect(headers.last .name).to eql('Nombre')
    expect(headers.last.value).to eql('This is translated too')
  end
end
