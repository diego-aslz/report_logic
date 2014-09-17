Gem::Specification.new do |s|
  s.name        = 'report_logic'
  s.version     = '0.0.1'
  s.date        = '2014-09-17'
  s.summary     = "Generating report logic."
  s.description = "This gem provides an easy way to generate reports' logic. "\
    "Using this, you can so export this report to any format you want."
  s.authors     = ["Diego Aguir Selzlein"]
  s.email       = 'diegoselzlein@gmail.com'

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]

  s.homepage    = 'https://github.com/nerde/report_logic'
  s.license     = 'MIT'

  s.add_dependency('i18n')
end
