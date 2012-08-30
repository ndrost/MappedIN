# caching (see below for details)
   Geocoder::Configuration.cache = Redis.new(:host => 'cod.redistogo.com', :port => '9469', :password => 'c3917eda45953051e439db4e2441e81f', :username => 'redistogo')
#   Geocoder::Configuration.cache = Redis.new
#   Geocoder::Configuration.cache_prefix = "..."
#   Geocoder::Configuration.lookup = :yahoo

