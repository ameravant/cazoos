# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.


ENV["RAILS_ENV"] ||= 'test'
require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
require File.dirname(__FILE__) + '/../db/seeds'
require 'spec/autorun'
require 'spec/rails'
require 'factory_girl'
require File.dirname(__FILE__) + '/factories'

# Uncomment the next line to use webrat's matchers
#require 'webrat/integrations/rspec-rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  config.mock_with :mocha

  # == Fixtures
  #
  # You can declare fixtures for each example_group like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so right here. Just uncomment the next line and replace the fixture
  # names with your fixtures.
  #
  # config.global_fixtures = :table_a, :table_b
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
  #
  # You can also declare which fixtures to use (for example fixtures for test/fixtures):
  #
  # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  #
  # == Mock Framework
  #
  # RSpec uses its own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  #
  # == Notes
  #
  # For more information take a look at Spec::Runner::Configuration and Spec::Runner
end
def missing_required_field_test(klass, field_name)
  @inst = klass.to_s.camelize.constantize.create(@valid_attributes.except(field_name.to_sym))
  @inst.should_not be_valid
  @inst.should be_new_record
  @inst.errors.on(field_name.to_sym).should include("can't be blank")
end

def set_up_record_stub(klass, valid = true, params = nil)
  klass = klass.to_s
  id = params && params[:id] ? params[:id] : 23498
  record = Factory.build(klass.to_sym)
  record.id = id
  eval "@#{klass} = record"
  klass = klass.camelize.constantize
  klass.stubs(:find).returns(record)
  klass.any_instance.stubs(:valid?).returns(valid)
  record.stubs(:save).returns(valid)
end

def stub_admin_login
  @current_user = stub(:user) do
    stubs(:has_role).with() { |val| val.include?('Admin') }.returns(true)
  end
  controller.stubs(:current_user).returns(@current_user)
end

def set_up_non_super_admin_user
  current_user = stub(:user) do
    stubs(:has_role).with() { |val| val.include?('Admin') }.returns(false)
    stubs(:has_role).with() { |val| !val.include?('Admin') }.returns(true)
  end
  controller.stubs(:current_user).returns(current_user)
end

def verify_root_redirect_with_access_error
  flash[:error].should include('do not have access')
  response.should redirect_to(root_url)
end

def twice
  [yield, yield]
end
