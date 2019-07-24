require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'


if Rails.env.development?                                                                                                                   
  CarrierWave.configure do |config|
    # developmentのもろもろの設定
    config.cache_storage = :file
    config.storage = :file
  end 
elsif Rails.env.test?
  CarrierWave.configure do |config|
    # testのもろもろの設定
    config.cache_storage = :file
    config.storage = :file
  end 
else
  CarrierWave.configure do |config|
    config.storage = :fog
    config.cache_storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
        :provider              => 'AWS',
        :aws_access_key_id     => ENV['S3_ACCESS_KEY_ID'],
        :aws_secret_access_key => ENV['S3_SECRET_KEY_ID'],
        :region                => ENV['S3_REGION'],
    }
    
    config.fog_directory = ENV['S3_BUCKET_NAME']
    config.fog_public = true
  end
end
