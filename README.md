# Bridgetown ActiveRecord plugin

## Installation

It's recommended you run our automation script to set up your project to support ActiveRecord and DB models:

```shell
$ bin/bridgetown apply https://github.com/bridgetownrb/bridgetown-activerecord
```

Or for a fully manual setup:

```shell
$ bundle add bridgetown-activerecord -g bridgetown_plugins
```

then replicate the individual steps outlined in the [automation script](https://github.com/bridgetownrb/bridgetown-activerecord/blob/main/bridgetown.automation.rb).

You will need to decide on your database adapter of choice. For a typical PostgreSQL configuration, add the `pg` gem.

```shell
$ bundle add pg
```

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

You're ready to roll to take full advantage of ActiveRecord database models in your Bridgetown site!

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
