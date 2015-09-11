Record = Struct.new(:id, :name)

FIRST_DECORATOR = ->(value) { value + 3 }
SECOND_DECORATOR = ->(value) { value / 2 }

class MyReport < ReportLogic::Base
  session :header do
    field 'ID'
    field 'Name'
  end

  collection_session :rows do |record|
    value record.id
    value record.name
  end

  def my_own_rows
    collection.map do |record|
      fields do
        value record.id
      end
    end
  end

  session :test_context do
    value context_value
  end

  session :decorated do
    field 'A', 1, decorate_name: ->(name) { name + 'B' },
                  decorate_value: [FIRST_DECORATOR, SECOND_DECORATOR]
  end

  def context_value
    'A'
  end
end
