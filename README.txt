DOCUMENTATION FOR THE CAZOOS MODULE

This plugin is done using Cucumber scenarios first, code second.  

NOTES on Cucumber:  
  Some assumptions are being made:
    1. There is a user with login(username) 'admin' and password 'admin' in the database at the start of the test.  This currently is being accomplished by a simple copy of the development database into the test database before the scenarios are run, not with factories in the test suite as one might expect.  The reason for this is that the rake task used to populate the development database does not run properly on the test environment (see line ~29 of ./features/support/env.rb)
