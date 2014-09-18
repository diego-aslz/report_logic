require 'spec_helper'

describe ReportLogic::Decorator do
  let(:decorator) { MyDecorator.new }
  let(:field)     { ReportLogic::Field.new(1, 2, key: :first) }

  describe "#decorate_if_matches" do

    it "decorates object" do
      decorator.decorate_if_matches(field)

      expect(field.value).to eql(3)
    end

    context "decorator does not match" do
      it "doesn't decorate" do
        decorator.stub(:matches?).and_return(false)

        decorator.decorate_if_matches(field)

        expect(field.value).to eql(2)
      end
    end

    context "key doesn't match" do
      let(:decorator) { ReportLogic::Decorator.new key: :second }

      it "doesn't decorate" do
        decorator.decorate_if_matches(field)

        expect(field.value).to eql(2)
      end
    end

    context "key is an array" do
      let(:decorator) { MyDecorator.new key: [:second] }

      it "checks inclusion" do
        f2 = ReportLogic::Field.new(1, 2, key: :second)

        decorator.decorate_if_matches(field)
        decorator.decorate_if_matches(f2)

        expect(field.value).to eql(2)
        expect(f2   .value).to eql(3)
      end
    end
  end
end
