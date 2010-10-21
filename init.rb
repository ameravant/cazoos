SETTINGS_FILE = "#{RAILS_ROOT}/config/cms.yml"
PERMISSIONS_FILE = "#{RAILS_ROOT}/config/permissions.yml"

require 'cazoos_person_ext'
require 'user_ext'
require 'cazoos_event_ext'

permissions = YAML::load_file(PERMISSIONS_FILE)
permissions["people"] = ["Admin", "Parent"]
permissions["events"] = ["Admin", "Organization Owner"]
permissions["orgs"] = ["Admin", "Organization Owner"]
permissions["offerings"] = ["Admin", "Organization Owner"]
permissions["activity_categories"] = "Admin"
File.open(PERMISSIONS_FILE, 'w') { |f| YAML.dump(permissions, f) }

settings = YAML::load_file(SETTINGS_FILE)
settings['features']['event_registration'] = true
File.open(SETTINGS_FILE, 'w') { |f| YAML.dump(settings, f) }
