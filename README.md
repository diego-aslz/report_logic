# ReportLogic

This gem provides an easy way to generate reports' logic.
You can organize the way your data needs to be grouped, converted and organized,
regardless how you are going to display it afterwards. I use this to export
the same report in various formats, like XLS and PDF, using the same Report
object.

## Installation

```bash
gem install report_logic
```

Using Bundler:

```ruby
gem 'report_logic'
```

## Usage

The goal here is to provide an easy way to extract report's logic to a Plain Old
Ruby Object. The report is defined by doing this:

```ruby
# Create a class inheriting from ReportLogic::Base
class MyReport < ReportLogic::Base

  # Create as many sessions as you need. Sessions group fields that you can
  # then display later.
  session :header do
    field 'ID'    # `field` creates a ReportLogic::Field in the session,
                  # which `name` will be the value passed to it.
    field 'Name'
  end

  # If you call `collection_session`, it will become a matrix, instead of
  # an array of Field. For each object in the collection given to the
  # constructor, the block will be yielded with it so you can define what Fields
  # will compose the matrix.
  collection_session :row do |record|
    value record.id     # `value` creates a ReportLogic::Field in the session,
                        # which `value` will be the value passed to it.
    value record.name
  end
end
```

And that's the basics. Now, to show this report:

```ruby
report = MyReport.new(MyModel.all)

# Printing a title
puts 'MY REPORT'

# Printing the headers
report.header.each do |field|
  print field.name
  print ' | '
end
puts

# Printing the rows
report.row.each do |row|
  row.each do |field|
    print field.value
    print ' | '
  end
  puts
end
```

This output is not pretty, but it shows how simple it is to read a report
and output it in any ways you want. You could use ERB to generate HTML or XLS
outputs in Rails, or even Prawn to generate PDF's.

## Decorators

This gem uses the Decorator Pattern to allow you to modify a Field before
printing. To do so, pass the decorator as a parameter to the field. It can be
any object, it just needs to respond to `call`. It can be a simple block.

```ruby
class MyDecorator
  def call(name)
    "=> #{name}"
  end
end

class MyReport < ReportLogic::Base
  collection_session :row do |record|
    field 'Name', record.name, decorate_name: MyDecorator.new,
                               decorate_value: ->(value) { " - #{value}" }
  end
end

MyModel = Struct.new(:name)
collection = [MyModel.new('John')]

MyReport.new(collection).row.each do |row|
  row.each do |field|
    puts field.name
    puts field.value
  end
end
#=> => Name
#=>  - John
```

If you need to apply multiple decorators on the same field, just pass an array.

## Contributing

Do you have an idea or a bug fix to add to the gem? Please do!

1. Fork it
2. Make your changes and commits
3. Create a pull request
