require 'spec_helper'

describe ReportLogic::Decorator do
  let(:decorator) { ReportLogic::Decorator.new }
  let(:field)     { ReportLogic::Field.new(1, 2) }

  describe "#decorate_if_matches" do
    it "raises error when #decorate is not implemented" do
      expect{ decorator.decorate_if_matches(field) }.to raise_error(NotImplementedError)
    end

    context '#decorate is implemented' do
      let(:decorator) { MyDecorator.new }

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
    end
  end
end
