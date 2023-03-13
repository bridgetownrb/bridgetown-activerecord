# frozen_string_literal: true

ENV["RAILS_ENV"] = Bridgetown.environment

require "active_record"
require "active_support/configuration_file"

module BridgetownActiveRecord
  def self.load_tasks(models_dir: "models")
    ENV["BRIDGETOWN_ACTIVERECORD_MODELS_DIR"] ||= models_dir
    load File.expand_path("../tasks/database.rake", __dir__)
  end

  def self.db_configuration(config)
    ActiveSupport::ConfigurationFile.parse(File.join(config.root_dir, "config", "database.yml"))
  end

  def self.log_writer
    Bridgetown::LogWriter.new.tap(&:enable_prefix)
  end
end

Bridgetown.initializer :"bridgetown-activerecord" do |config, sequel_support: nil|
  ActiveRecord::Base.establish_connection(
    BridgetownActiveRecord.db_configuration(config)[Bridgetown.environment]
  )
  ActiveRecord::Base.logger = BridgetownActiveRecord.log_writer

  next unless sequel_support

  require "sequel"
  DB = Sequel.send(sequel_support, extensions: :activerecord_connection) # rubocop:disable Lint/ConstantDefinitionInBlock
end
