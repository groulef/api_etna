require 'tool/warning_filter'
require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  project_name 'tool'
  minimum_coverage 100
  coverage_dir '.coverage'

  add_filter '/spec/'
  add_group 'Library', 'lib'
end
