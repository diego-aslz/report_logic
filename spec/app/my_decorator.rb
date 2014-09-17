class MyDecorator < ReportLogic::Decorator
  def decorate(field)
    field.value = 3
  end
end
