require 'rails/railtie'
require 'cloud_gate/version'

module CloudGate
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load 'cloud_gate/tasks/db.rake'
    end
  end
end
