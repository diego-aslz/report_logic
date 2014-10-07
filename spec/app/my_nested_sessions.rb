class MyNestedSessions < ReportLogic::Base
  def build
    session :parent do
      value "I'm a father!"

      session :child, [1, 2] do
        value "bééééé"
      end
    end
  end
end
