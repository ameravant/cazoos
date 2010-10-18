require 'cazoos_person_ext'
require 'user_ext'
require 'cazoos_event_ext'

permissions = YAML::load_file("#{RAILS_ROOT}/config/permissions.yml")
permissions["people"] = ["Admin", "Parent"]
permissions["events"] = ["Admin", "Organization Owner"]
permissions["orgs"] = ["Admin", "Organization Owner"]
permissions["offerings"] = ["Admin", "Organization Owner"]
permissions["activity_categories"] = "Admin"
File.open("#{RAILS_ROOT}/config/permissions.yml", 'w') { |f| YAML.dump(permissions, f) }
