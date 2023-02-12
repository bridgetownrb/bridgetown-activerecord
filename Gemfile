# frozen_string_literal: true

source "https://rubygems.org"
gemspec

gem "bridgetown", ENV["BRIDGETOWN_VERSION"] if ENV["BRIDGETOWN_VERSION"]

group :test do
  gem "minitest"
  gem "minitest-reporters"
  gem "pg", "~> 1.3"
  gem "sequel-activerecord_connection", "~> 1.2"
  gem "shoulda"
end
