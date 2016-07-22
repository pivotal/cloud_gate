require 'json'

namespace :db do
  namespace :connect do
    desc 'Connect to staging database'
    task :staging do
      remote = get_remote_credentials(org: CloudGate.configuration[:org_name], space: CloudGate.configuration[:staging_info][:space_name], db: CloudGate.configuration[:staging_info][:database_service_name], key: 'SSH')
      tunnel(to: remote, app: CloudGate.configuration[:staging_info][:app_name]) do
        sh("MYSQL_PWD=#{remote.password} mysql -u #{remote.username} -h 0 -P 9999 -D #{remote.name}")
      end
    end

    desc 'Connect to production database'
    task :production do
      remote = get_remote_credentials(org: CloudGate.configuration[:org_name], space: CloudGate.configuration[:production_info][:space_name], db: CloudGate.configuration[:production_info][:database_service_name], key: 'SSH')
      tunnel(to: remote, app: CloudGate.configuration[:production_info][:app_name]) do
        sh("MYSQL_PWD=#{remote.password} mysql -u #{remote.username} -h 0 -P 9999 -D #{remote.name}")
      end
    end
  end
end

def get_remote_credentials(org:, space:, db:, key:)
  `cf target -o #{org} -s #{space}`
  fail 'Error running cf target' if $?.exitstatus > 0
  json = JSON.parse(`cf service-key #{db} #{key} | tail +3`)
  OpenStruct.new(username: json['username'], password: json['password'], host: json['hostname'], port: json['port'], name: json['name'])
end

def tunnel(to:, app:, &block)
  pid = spawn("cf ssh -N -L 9999:#{to.host}:#{to.port} #{app}")
  fail 'Error setting up ssh tunnel' unless pid
  sleep 5
  block.call
  Process.kill(:SIGINT, pid)
end
