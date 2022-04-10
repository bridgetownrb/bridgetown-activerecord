# frozen_string_literal: true

source "https://rubygems.org"
gemspec

gem "bridgetown", ENV["BRIDGETOWN_VERSION"] if ENV["BRIDGETOWN_VERSION"]

group :test do
  gem "minitest"
  gem "minitest-reporters"
  gem "shoulda"
end

gem "pg", "~> 1.3", group: :test
