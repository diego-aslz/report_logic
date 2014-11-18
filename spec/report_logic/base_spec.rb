require 'spec_helper'

describe ReportLogic::Base do
  let(:rec1) { Record.new(1, 'Diego') }
  let(:rec2) { Record.new(2, 'Andressa') }

  let(:report) { MyReport.new([rec1, rec2]) }

  let(:headers) { report.each(:header) }
  let(:rows)    { report.each(:rows) }

  it "generates grouped fields" do
    expect(headers.count    ).to eql(2)
    expect(headers.next.name).to eql('ID')
    expect(headers.next.name).to eql('Name')


    expect(rows.count    ).to eql(2)

    first_row = rows.next
    expect(first_row.first.value).to eql(1)
    expect(first_row.last.value ).to eql('Diego')

    last_row = rows.next
    expect(last_row.first.value ).to eql(2)
    expect(last_row.last.value  ).to eql('Andressa')
  end

  it "counts records" do
    expect(report.count).to eq 2
  end

  it "scopes decorators" do
    s1 = report.each(:test_master_decorator).to_a
    s2 = report.each(:exclusive_decorator  ).to_a

    expect(s1.first.value).to eq(3)
    expect(s2.first.value).to eq(3)
  end
end
