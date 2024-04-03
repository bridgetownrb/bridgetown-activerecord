# Bridgetown Active Record plugin

> [!CAUTION]
> This plugin is being deprecated in favor of the new [Bridgetown Sequel](https://github.com/bridgetownrb/bridgetown_sequel) plugin. We recommend all new Bridgetown sites with database requirements use Sequel, which provides many of the same features as Active Record and offers a simple plugin API and configuration options for Bridgetown.

---

This plugin adds [Active Record](https://guides.rubyonrails.org/active_record_basics.html) support to Bridgetown sites (v1.2 or higher). You can pull data from a database (currently PostgreSQL is officially supported) during a static build or during server requests (or both!) and use many of the features you know and love from Active Record in Rails—including migrations!

In addition, if you also like using the [Sequel gem](https://github.com/jeremyevans/sequel) for your database access, this plugin can support instantiating Sequel with a shared DB connection via the [sequel-activerecord_connection](https://github.com/janko/sequel-activerecord_connection) extension ([see below](#using-with-sequel)).

## Installation

> **IMPORTANT NOTE:** there's currently a compatibilty issue between Rails 7 gems and Rack version 3. For now, please add `gem "rack", "~> 2.2"` to your Gemfile _before_ you install this plugin.

It's recommended you run our automation script to set up your project to support Active Record and DB models:

```shell
$ bin/bridgetown apply https://github.com/bridgetownrb/bridgetown-activerecord
```

Or for a fully manual setup:

```shell
$ bundle add bridgetown-activerecord
```

then replicate the individual steps outlined in the [automation script](https://github.com/bridgetownrb/bridgetown-activerecord/blob/main/bridgetown.automation.rb).

You will need to decide on your database adapter of choice. For a typical PostgreSQL configuration, add the `pg` gem.

```shell
$ bundle add pg
```

When deploying to production, the `DATABASE_URL` ENV var will need to be set with the appropriate connection string…many hosting services will do this for you automatically.

## Usage

Let's create a simple Movie model to load and save our favorite movies. Add the file `models/movie.rb`:

```rb
class Movie < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_insensitive: true }

  def uppercase_title
    title.upcase
  end
end
```

Then add a new migration for the Movie model.

```sh
$ bin/bridgetown db:new_migration name=create_movies
```

That will create a new migration file in `db/migrate`. Edit the file so it looks like this:

```ruby
class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.string :director
      t.integer :year

      t.timestamps
    end
  end
end
```

Awesome, now let's create the database and run the migration!

```sh
$ bin/bridgetown db:create
$ bin/bridgetown db:migrate
```

If all goes well, the database should be created, the migration run, a new `db/schema.rb` saved, and schema annotations added to the top of `models/movie.rb`!

Let's try it out in the Bridgetown console.

```sh
$ bin/bridgetown console
```

```ruby
> Movie.count
0
> Movie.create(title: "Free Guy", director: "Shawn Levy", year: "2021") 
> Movie.count
1
> Movie.last
#<Movie:0x0000000109e26378> {
          :id => 1,
       :title => "Free Guy",
    :director => "Shawn Levy",
        :year => 2021,
  :created_at => 2022-03-12 23:24:28.98137 UTC,
  :updated_at => 2022-03-12 23:24:28.98137 UTC
}
```

You're ready to roll to take full advantage of Active Record database models in your Bridgetown site!

## Changing the Models Directory

If you'd prefer to set up your models folder elsewhere other than `./models`, you can move the files to another path and then update your Rakefile to pass in that path. For example, you could use the more familiar `app/models`:

```ruby
require "bridgetown-activerecord"
BridgetownActiveRecord.load_tasks(models_dir: "app/models")
```

(Don't forget to update your autoload path in `config/initializers.rb` accordingly.)

## Using with Sequel

To set up [Sequel](https://github.com/jeremyevans/sequel) using the same database connection as Active Record, follow these steps:

First, install the sequel-activerecord_connection gem:

```sh
bundle add sequel-activerecord_connection
```

Next, update your configuration in `config/initializers.rb` as follows:

```ruby
init :"bridgetown-activerecord", sequel_support: :postgres # or mysql2 or sqlite3
```

Now you should be able to call `DB` to access the Sequel API anywhere in your Bridgetown or Roda code:

```ruby
DB.tables # => [:ar_internal_metadata, :schema_migrations, etc.]
```

## Testing

* Run `bundle exec rake test` to run the test suite
* Or run `script/cibuild` to validate with Rubocop and Minitest together.

## Contributing

1. Fork it (https://github.com/bridgetownrb/bridgetown-activerecord/fork)
2. Clone the fork using `git clone` to your local development machine.
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
