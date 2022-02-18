require "simplecov"

SimpleCov.start do
  add_filter "/test/"

  if ENV["CI"]
    require "simplecov-lcov"

    SimpleCov::Formatter::LcovFormatter.config do |c|
      c.report_with_single_file = true
      c.single_report_path = "coverage/lcov.info"
    end

    formatter SimpleCov::Formatter::LcovFormatter
  end
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "dns_stamp"
require "minitest/autorun"
