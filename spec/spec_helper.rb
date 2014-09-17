require File.expand_path('../../lib/report_logic', __FILE__)

Dir[File.expand_path('../app/*.rb', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.order = "random"
  config.before(:each) { GC.disable }
  config.after(:each)  { GC.enable }
end
