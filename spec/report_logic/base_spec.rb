require 'spec_helper'

describe ReportLogic::Base do
  let(:rec1) { Record.new(1, 'Diego') }
  let(:rec2) { Record.new(2, 'Andressa') }

  let(:report) { MyReport.new([rec1, rec2]) }

  let(:headers) { report.header }
  let(:rows)    { report.rows }
  let(:decorated) { report.decorated }

  it 'generates grouped fields' do
    expect(headers.count).to eql(2)
    expect(headers.first.name).to eql('ID')
    expect(headers.last.name).to eql('Name')

    expect(rows.count).to eql(2)

    first_row = rows.first
    expect(first_row.first.value).to eql(1)
    expect(first_row.last.value ).to eql('Diego')

    last_row = rows.last
    expect(last_row.first.value ).to eql(2)
    expect(last_row.last.value  ).to eql('Andressa')
  end

  it 'allows to define methods directly' do
    expect(report.my_own_rows.size).to eq 2
    expect(report.my_own_rows.first.map(&:value)).to eq [1]
    expect(report.my_own_rows.last.map(&:value)).to eq [2]
  end

  it 'decorates names and values' do
    expect(decorated.first.name).to eql('AB')
    expect(decorated.first.value).to eql(2)
  end

  it 'counts records' do
    expect(report.count).to eq 2
  end
end
