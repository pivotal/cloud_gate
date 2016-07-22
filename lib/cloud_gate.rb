require 'rails/railtie'
require 'cloud_gate/version'

module CloudGate
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= {}
  end

  def self.configure
    yield(configuration)
  end

  class Railtie < ::Rails::Railtie
    rake_tasks do
      load 'cloud_gate/tasks/db.rake'
    end
  end
end
