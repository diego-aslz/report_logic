require 'spec_helper'

describe ReportLogic::Grouper do
  let(:grouper) { ReportLogic::Grouper.new }
  let(:result)  { grouper.result }
  let(:field)   { grouper.result.first }

  it "generates fields with name" do
    grouper.field 'Test Field'

    expect(result.size).to eq(1)
    expect(field.key  ).to be_nil
    expect(field.name ).to eq('Test Field')
    expect(field.value).to be_nil
  end

  it "generates fields with value" do
    grouper.value 'Test Field'

    expect(result.size).to eq(1)
    expect(field.key  ).to be_nil
    expect(field.name ).to be_nil
    expect(field.value).to eq('Test Field')
  end

  it "generates fields with name and value" do
    grouper.field 'Test Field', 'Value'

    expect(result.size).to eq(1)
    expect(field.key  ).to be_nil
    expect(field.name ).to eq('Test Field')
    expect(field.value).to eq('Value')
  end

  it "generates fields with key" do
    grouper.field 'Test Field', 'Value', key: :sparta

    expect(result.size).to eq(1)
    expect(field.key  ).to eq(:sparta)
    expect(field.name ).to eq('Test Field')
    expect(field.value).to eq('Value')
  end

  it "uses name as key when it's a symbol" do
    grouper.field :name

    expect(result.size).to eq(1)
    expect(field.key  ).to eq(:name)
    expect(field.name ).to eq(:name)
    expect(field.value).to be_nil
  end
end
