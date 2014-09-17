require 'spec_helper'

describe ReportLogic::Session do
  let(:session) { ReportLogic::Session.new }
  let(:fields)  { session.fields }
  let(:field)   { session.fields.first }

  it "generates fields with name" do
    session.field 'Test Field'

    expect(fields.size).to eq(1)
    expect(field.key  ).to be_nil
    expect(field.name ).to eq('Test Field')
    expect(field.value).to be_nil
  end

  it "generates fields with value" do
    session.value 'Test Field'

    expect(fields.size).to eq(1)
    expect(field.key  ).to be_nil
    expect(field.name ).to be_nil
    expect(field.value).to eq('Test Field')
  end

  it "generates fields with name and value" do
    session.field 'Test Field', 'Value'

    expect(fields.size).to eq(1)
    expect(field.key  ).to be_nil
    expect(field.name ).to eq('Test Field')
    expect(field.value).to eq('Value')
  end

  it "generates fields with key" do
    session.field 'Test Field', 'Value', key: :sparta

    expect(fields.size).to eq(1)
    expect(field.key  ).to eq(:sparta)
    expect(field.name ).to eq('Test Field')
    expect(field.value).to eq('Value')
  end

  it "uses name as key when it's a symbol" do
    session.field :name

    expect(fields.size).to eq(1)
    expect(field.key  ).to eq(:name)
    expect(field.name ).to eq(:name)
    expect(field.value).to be_nil
  end

  it "decorates fields" do
    session.field 'First Field' , 1
    session.field 'Second Field', 2
    session.decorator MyDecorator.new

    session.decorate

    expect(fields.first.value).to eq(3)
    expect(fields.last .value).to eq(3)
  end
end
