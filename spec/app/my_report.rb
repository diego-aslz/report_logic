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

    session(:test_master_decorator) do
      field :decorable, 2
    end

    session(:exclusive_decorator) do
      value 2
      decorate_with MyDecorator.new
    end

    decorate_with MyDecorator.new(key: :decorable)
  end

  def context_value
    'A'
  end
end
