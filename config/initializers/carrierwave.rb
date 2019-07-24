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
    # productionのもろもろの設定
    config.cache_storage = :fog # fogを使う環境だけに適用！
    config.storage = :fog
  end 
end
