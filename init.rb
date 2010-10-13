require 'cazoos_person_ext'
require 'user_ext'
permissions = YAML::load_file("#{RAILS_ROOT}/config/permissions.yml")
permissions["people"] = ["Admin", "Parent"]
File.open("#{RAILS_ROOT}/config/permissions.yml", 'w') { |f| YAML.dump(permissions, f) }