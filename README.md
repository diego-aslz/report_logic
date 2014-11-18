# ReportLogic

This gem provides an easy way to generate reports' logic.
Using this, you can so export this report to any format you want.

## Installation

```bash
gem install report_logic
```

Using Bundler:

```ruby
gem 'report_logic', '~> 0.1.1'
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

# Printing the rows
report.each(:row) do |row|
  row.each do |field|
    print field.value
    print ' | '
  end
  puts
end
```

This output sucks, but it shows how simple it is to read a report
and output it in any ways you want. You could use ERB to generate HTML or XLS
outputs in Rails, or even Prawn to generate PDF's.

## Decorators

This gem uses the Decorator pattern to allow you to modify a Field before
printing. To do so, you just need to inherit from `ReportLogic::Decorator`,
like so:

```ruby
class MyDecorator < ReportLogic::Decorator
  # This method is invoked when the report is built. Override this if you
  # want to customize the whole behaviour of your decorator.
  def decorate(field)
    decorate_name(field)
    decorate_value(field)
  end

  # This method is called by default from ReportLogic::Decorator, as
  # you can see above. Override this if you just want to decorate the name
  # attribute of your fields.
  def decorate_name(field); end

  # This method is called by default from ReportLogic::Decorator as well.
  # Override this if you just want to decorate the value attribute of your fields.
  def decorate_value(field); end
end
```

This sample decorator is, in fact, pretty much the same as
`ReportLogic::Decorator`. For more details, take a look at the class itself.

You can then apply a decorator in many ways:

```ruby
class MyReport < ReportLogic::Base
  def build
    session(:row, collection) do |record|
      field 'Name', record.name
      field 'Gender', record.gender

      decorate_with MyDecorator.new    # This decorator applies to this session
    end

    decorate_with AnotherDecorator.new # This decorator applies to the whole report
  end
end
```

You can apply a decorator to a specific field. To do so, you need to:

```ruby
field 'Name', record.name, decorate_with: SpecificDecorator.new
```

## I18n Support

There is a built-in decorator that handles internationalization for you. To use
it, you need to do this:

```ruby
class MyReport < ReportLogic::Base
  include ReportLogic::I18nSupport  # Include de module

  def build
    i18n_decorate                   # Invoke the decorator to be added

    session(:row, collection) do |record|
      field 'Name', record.name
      field 'Gender', record.gender
    end
  end
end
```

This way, your fields' names and values will be translated **if they are symbols**.
So, to make it work, you need to use symbols:

```ruby
class MyReport < ReportLogic::Base
  include ReportLogic::I18nSupport

  def build
    i18n_decorate

    session(:filter) do
      field :name  , 'Test'   # The field's name will be translated using
                              # 'report.names.name'
      field :gender, :male    # The field's name will be translated using
                              # 'report.names.gender' and the value will use
                              # 'report.values.male'.
    end
  end
end
```

## Contributing

Do you have an idea or a bug fix to add to the gem? Please do!

1. Fork it
2. Make your changes and commits
3. Create a pull request
