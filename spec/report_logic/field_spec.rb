require 'spec_helper'

module ReportLogic
  describe Field do
    it 'stores extra arguments in config' do
      field = Field.new(nil, extra1: :a, extra2: :b)

      expect(field.config).to eq({ extra1: :a, extra2: :b })
    end
  end
end
