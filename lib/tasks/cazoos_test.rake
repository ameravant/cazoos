namespace :cazoos do
  desc "setup test environment"
  task :cucumber_setup => :environment do
    system("cd #{RAILS_ROOT} && rm -rf test && rm -rf spec && rm -rf features")
    system("cd #{RAILS_ROOT} && ln -s ./vendor/plugins/siteninja/cazoos/test test")
    system("cd #{RAILS_ROOT} && ln -s ./vendor/plugins/siteninja/cazoos/spec spec")
    system("cd #{RAILS_ROOT} && ln -s ./vendor/plugins/siteninja/cazoos/features features")
  end
end