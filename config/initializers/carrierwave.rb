#require 'carrierwave/storage/abstract'
#require 'carrierwave/storage/file'
#require 'carrierwave/storage/fog'
#require 'aws-sdk'
require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

if Rails.env.development?                                                                                                              
  CarrierWave.configure do |config|
    # developmentのもろもろの設定
    #config.cache_storage = :file
    #config.storage = :file
    #config.cache_storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
        :provider              => 'AWS',
        :region                => ENV['S3_REGION'],
        #:s3_access_key_id     => ENV['S3_ACCESS_KEY_ID'],
        #:s3_secret_access_key => ENV['S3_SECRET_KEY_ID'],
        #:region                => ENV['S3_REGION'],
        :aws_access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
        :aws_secret_access_key => ENV['AWS_SECRET_ACESSS_KEY']
    }
    #config.storage = :fog
    
    config.fog_directory = ENV['S3_BUCKET']
    #config.fog_public = true
  end 
elsif Rails.env.test?
  CarrierWave.configure do |config|
    # testのもろもろの設定
    config.cache_storage = :file
    config.storage = :file
  end 
else
  CarrierWave.configure do |config|
    #config.fog_provider = 'fog/aws'
    #config.storage = :fog
    #config.cache_storage = :fog
    #config.fog_credentials = {
    #    :provider              => 'AWS',
    #    :aws_access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
    #    :aws_secret_access_key => ENV['AWS_SECRET_ACEESS_KEY'],
    #    :region                => ENV['S3_REGION']
    #    #:aws_access_key_id     => ENV['AWS_ACCESS_KEY_ID'],
    #    #:aws_secret_access_key => ENV['AWS_SECRET_KEY_ID'],
    #    #:region                => ENV['S3_REGION'],
    #}
    
    #config.fog_directory = ENV['S3_BUCKET']
    #config.fog_public = true
  end
end
