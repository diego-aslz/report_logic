require 'spec_helper'

describe ReportLogic::Decorator do
  let(:group)     { :body }
  let(:decorator) { ReportLogic::Decorator.new }
  let(:field)     { ReportLogic::Field.new(1, 2, key: :first) }

  describe "#decorate_if_matches" do
    it "raises error when #decorate is not implemented" do
      expect{ decorator.decorate_if_matches(field) }.to raise_error(NotImplementedError)
    end

    context '#decorate is implemented' do
      let(:options)   { { } }
      let(:decorator) { MyDecorator.new **options }

      it "decorates object" do
        decorator.decorate_if_matches(field)

        expect(field.value).to eql(3)
      end

      context "group doesn't match" do
        let(:options) { { group: :header } }

        it "doesn't decorate" do
          decorator.decorate_if_matches(field)

          expect(field.value).to eql(2)
        end
      end

      context "key doesn't match" do
        let(:options) { { key: :second } }

        it "doesn't decorate" do
          decorator.decorate_if_matches(field)

          expect(field.value).to eql(2)
        end
      end
    end
  end
end
