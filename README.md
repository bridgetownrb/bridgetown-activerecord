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

TBC

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
