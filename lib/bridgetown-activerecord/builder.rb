# frozen_string_literal: true

ENV["RAILS_ENV"] = Bridgetown.environment

require "active_record"
require "active_support/configuration_file"

module BridgetownActiveRecord
  def self.load_tasks
    load File.expand_path("../tasks/database.rake", __dir__)
  end

  class Builder < Bridgetown::Builder
    def self.db_configuration(site)
      ActiveSupport::ConfigurationFile.parse(site.in_root_dir("config", "database.yml"))
    end

    def self.log_writer
      Bridgetown::LogWriter.new.tap(&:enable_prefix)
    end

    Bridgetown::Hooks.register_one :site, :after_init, reloadable: false do |site|
      ActiveRecord::Base.establish_connection db_configuration(site)[Bridgetown.environment]
      ActiveRecord::Base.logger = log_writer
    end

    # no-op
    def build; end
  end
end

BridgetownActiveRecord::Builder.register
