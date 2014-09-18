# ReportLogic

This gem provides an easy way to generate reports' logic.
Using this, you can so export this report to any format you want.

## Installation

```bash
gem install report_logic
```

Using bundler:

```ruby
gem 'report_logic'
```

## Usage

The goal here is to provide an easy way to extract report's logic to a Plain Old
Ruby Object. With this extraction, it's easy to use the same report class to
render reports in different formats. The report is defined by doing this:

```ruby
# Create a class inheriting from ReportLogic::Base
class MyReport < ReportLogic::Base

  # Override this method to define your report
  def build
    # Create as many sessions as you need. Sessions group fields that you can
    # then display later.
    session(:header) do
      field 'ID'    # `field` creates a ReportLogic::Field in the session,
                    # which `name` will be the value passed to it.
      field 'Name'
    end

    # If you pass a collection to a session, it will become a matrix, instead of
    # an array of Field. For each object in the collection, the block will be
    # yielded with it so you can define what Fields will compose this matrix.
    session(:row, collection) do |record|
      value record.id     # `value` creates a ReportLogic::Field in the session,
                          # which `value` will be the value passed to it.
      value record.name
    end
  end
end
```

And that's the basics. Now, to show this report:

```ruby
report = MyReport.new(MyModel.all)

# Printing a title
puts 'MY REPORT'

# Printing the headers
report.each(:header) do |field|
  print field.name
  print ' | '
end
puts

report.each(:row) do |row|
  row.each do |field|
    print field.value
    print ' | '
  end
end
puts
```

This output sucks, but it shows how simple it is to read a report
and output it in any ways you want. You could use ERB to generate HTML or XLS
outputs in Rails, or even Prawn to generate PDF's.
