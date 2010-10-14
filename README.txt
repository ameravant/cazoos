DOCUMENTATION FOR THE CAZOOS MODULE

This plugin is done creating Cucumber scenarios first, code second.  

NOTES on Cucumber:  
  Some assumptions are being made:
    1. There is a user with login(username) 'admin' and password 'admin' in the database at the start of the test.  This currently is being accomplished by a simple copy of the development database into the test database before the scenarios are run, not with factories in the test suite as one might expect.  The reason for this is that the rake task used to populate the development database does not run properly on the test environment (see line ~29 of ./features/support/env.rb)

To set up the test environment, run rake cazoos:cucumber_setup
You will then be able to run cucumber features from the base app.

There are several files that need to be set up out of RAILS_ROOT in order for things to run properly:

config/environments/(test.rb,cucumber.rb)
config/initializers/require_factories.rb  (not required but useful, contains the line "require 'factory_girl' if RAILS_ENV=='test'")
lib/tasks/(cucumber.rake,spec.rake)

db/seeds.rb should point to vendor/plugins/siteninja/cazoos/db/seeds.rb
