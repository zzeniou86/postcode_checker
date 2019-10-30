# Postcode Checker

A simple web app in Rails, which works out if a given postcode is within a service area.

## Configuration

The app relies on the YAML file `config/whitelist.yml` to work out if a postcode is serviceable or not. The file should look like this:

```yaml
lsoas:
  - Southwark
  - Lambeth
postcodes:
  - SH24 1AA
  - SH24 1AB
```

To whitelist more postcodes, please add them under _postcodes_. To whitelist omore lsoas, please add them under _lsoas_.

After editing the file, restart the server if needed.

## System Dependencies
* [Ruby 2.6.5](https://www.ruby-lang.org/en/news/2019/10/01/ruby-2-6-5-released/)

* [Node (LTS: Ebrium)](https://nodejs.org/en/)

* [Bundler](https://bundler.io/)

* [Headless Chrome](https://chromium.googlesource.com/chromium/src/+/lkgr/headless/README.md) - Rails will install it automatically if it's missing

## Installation & Running
```sh
$ bundle install
$ npm install -g yarn
$ rails  webpacker:install
$ rails s
```
Please note that the application uses Rails v6 and does not require any database to run.

## Running tests
To run all the unit and functional tests:
```sh
$ rails test
```
To run all the integration and e2e tests:
```sh
$ rails test:system
```

The integration and e2e tests use headless chrome. Also all external requests are replayed offline with the help of [vcr](https://github.com/vcr/vcr) library

## Development

The project focuses mainly on the following files:
```
config/routes.rb

app/controllers/postocodes_controller.rb
app/helpers/postcodoes_helper.rb

views/postcodes/index.html.erb
views/postcodes/check_whitelist.js.erb

services/postcodes_io/client.rb
commands/whitelist_checker.rb

config/whitelist.yml
initializers/postcode_whitelists.rb

test/test_helper.rb
test/commands/whitelist_checker_test.rb
test/controllers/postcodes_controller_test.rb
test/services/postcodes_io_client_test.rb
test/system/postcodes_integration_test.rb
test/system/journey_test.rb
```

## Linting and formatting

The project relies on [rubocop](https://github.com/rubocop-hq/rubocop) for static code analysis. Simply run the command `$ rubocop` on the terminal.

## TODO
- [ ] Remove boilerplate files and libraries (i.e. database and ActiveRecord).
- [ ] Add documentation for the modules and classes.
