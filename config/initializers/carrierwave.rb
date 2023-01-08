require 'carrierwave/orm/activerecord'
CarrierWave.configure do |config|
    config.storage = :webdav
    config.webdav_server = 'http://192.168.100.12/webdav' # Your WebDAV url.
    # config.webdav_write_server = 'http://192.168.100.12/webdav' # This is an optional attribute. It can save on one server and read from another server. (Contributed by @eychu. Thanks)
    # config.webdav_autocreates_dirs = true # if automatic directory creation is enabled on the server (disables explicit directory creation)
    config.webdav_username = 'clicktechlabs'
    config.webdav_password = 'clicktechlabs'
  end