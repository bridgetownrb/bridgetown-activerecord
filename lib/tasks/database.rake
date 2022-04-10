# Setup ActiveRecord tasks like db:migrate, etc.
# Also see .standalone_migrations config file in project root
ENV["RAILS_ENV"] = Bridgetown.environment
ENV["SCHEMA"] = File.join(Dir.pwd, "db", "schema.rb")
require "standalone_migrations"
StandaloneMigrations::Tasks.load_tasks

# Setup Annotate so it runs on db:migrate, etc.
require "annotate"
require "./models/application_record"
ENV["model_dir"] = "models"
Annotate::Helpers.class_eval do
  # We need to redefine this because our custom model_dir shortcircuits the migration task enhancement
  def self.include_models?
    true
  end
end
Annotate.load_tasks
