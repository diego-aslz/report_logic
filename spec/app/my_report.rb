Record = Struct.new(:id, :name)

class MyReport < ReportLogic::Base
  def build
    session(:header) do
      field 'ID'
      field 'Name'
    end

    session(:rows, collection) do |record|
      value record.id
      value record.name
    end

    session(:test_context) do
      context_value
    end
  end

  def context_value
    'A'
  end
end
