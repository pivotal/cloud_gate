require 'spec_helper'

describe CloudGate do
  it 'has a version number' do
    expect(CloudGate::VERSION).not_to be nil
  end

  describe '.configure' do
    before do
      CloudGate.configure do |config|
        config[:org_name] = 'Marsupials International'
        config[:staging_info] = {
          space_name: 'australia-staging',
          app_name: 'wombats-staging',
          database_service_name: 'wombats-staging-db',
          service_key_name: 'SSH'
        }
        config[:production_info] = {
          space_name: 'australia-production',
          app_name: 'wombats-production',
          database_service_name: 'wombats-production-db',
          service_key_name: 'SSH'
        }
      end
    end

    it 'sets the configuration on the main class' do
      expect(CloudGate.configuration[:org_name]).to eq('Marsupials International')

      expect(CloudGate.configuration[:staging_info][:space_name]).to eq('australia-staging')
      expect(CloudGate.configuration[:staging_info][:app_name]).to eq('wombats-staging')
      expect(CloudGate.configuration[:staging_info][:database_service_name]).to eq('wombats-staging-db')
      expect(CloudGate.configuration[:staging_info][:service_key_name]).to eq('SSH')

      expect(CloudGate.configuration[:production_info][:space_name]).to eq('australia-production')
      expect(CloudGate.configuration[:production_info][:app_name]).to eq('wombats-production')
      expect(CloudGate.configuration[:production_info][:database_service_name]).to eq('wombats-production-db')
      expect(CloudGate.configuration[:production_info][:service_key_name]).to eq('SSH')
    end
  end
end
