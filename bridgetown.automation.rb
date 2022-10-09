add_gem "bridgetown-activerecord"
add_gem "annotate", group: :development

# TODO:
#dboptions = ["postgresql", "mysql", "vanilla"]
#dbadapter = ask("Which adapter should be used for your database?", limited_to: dboptions)

dbadapter = "postgresql"
dbprefix = ask("What identifier should be used for your database prefix?", default: "bt_demo")

# TODO: use Rails DB templates
#rails_db_tmpl_url = "https://github.com/rails/rails/blob/7-0-stable/railties/lib/rails/generators/rails/app/templates/config/databases/"

create_file "config/database.yml" do
  <<~YML
    default: &default
      adapter: #{dbadapter}
      encoding: unicode
      pool: 5

    development:
      <<: *default
      database: #{dbprefix}_development

    test: &test
      <<: *default
      database: #{dbprefix}_test

    production:
      <<: *default
      url: <%= ENV['DATABASE_URL'] %>
      database: #{dbprefix}_production
  YML
end

create_file "models/application_record.rb" do
  <<~RUBY
    require "active_record"

    class ApplicationRecord < ActiveRecord::Base
      primary_abstract_class
    end
  RUBY
end

create_file ".standalone_migrations" do
  <<~YML
    config:
      database: config/database.yml
  YML
end

insert_into_file "Rakefile", "require \"bridgetown-activerecord\"\nBridgetownActiveRecord.load_tasks\n", :after => "Bridgetown.load_tasks\n"

ruby_configure "Support for autoloading models" do
  <<~RUBY
    config.autoload_paths << {
      path: "models",
      eager: true
    }

    config.autoloader_collapsed_paths << "models/concerns"
  RUBY
end

add_initializer :"bridgetown-activerecord"

say_status :active_record, "The plugin has been configured. For usage help visit:"
say_status :active_record, "https://github.com/bridgetownrb/bridgetown-activerecord/blob/main/README.md"

say_status :active_record, "Don't forget to add a specific database adapter to your Gemfile! For example:"
say_status :active_record, "$ bundle add pg".bold
