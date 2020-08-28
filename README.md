# Coll8Api

Ruby wrapper for Coll-8 API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coll_8_api', branch: 'master', github: 'BloomAndWild/coll_8_api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install coll_8_api

## Usage

## Configure client
```
  Coll8Api::Client.configure do |config|
    config.base_url = ENV["COLL_8_BASE_URL"]
    config.client_id = ENV["COLL_8_CLIENT_ID"]
    config.client_secret = ENV["COLL_8_CLIENT_SECRET"]
    config.account = ENV["COLL_8_ACCOUNT"]

    config.logger = Logger.new(STDERR)
  end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Running specs

To run the specs, add your development credentials to your dev env:
```
COLL_8_BASE_URL= https://ship-api-uat.drop2shop.ie/api/
COLL_8_CLIENT_ID=<YOUR CLIENT ID>
COLL_8_CLIENT_SECRET=<YOUR CLIENT SECRET>
COLL_8_ACCOUNT=123456789
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/coll_8_api.

