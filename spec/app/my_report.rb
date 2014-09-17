Record = Struct.new(:id, :name)

class MyReport < ReportLogic::Base
  def build
    group(:header) do
      field 'ID'
      field 'Name'
    end

    group(:rows, collection) do |record|
      value record.id
      value record.name
    end
  end
end
