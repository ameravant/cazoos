namespace :cazoos do
  desc "setup test environment"
  task :cucumber_setup => :environment do
    system("ln -s #{RAILS_ROOT}/vendor/plugins/siteninja/cazoos/test #{RAILS_ROOT}/test")
    system("ln -s #{RAILS_ROOT}/vendor/plugins/siteninja/cazoos/spec #{RAILS_ROOT}/spec")
    system("ln -s #{RAILS_ROOT}/vendor/plugins/siteninja/cazoos/features #{RAILS_ROOT}/features")
  end
end