# caching (see below for details)
   Geocoder::Configuration.cache = Redis.new(:host => 'cod.redistogo.com', :port => '9469', :password => 'f7f468e09bce8d5137d1d4922b4a6f4a', :username => 'redistogo')
#   Geocoder::Configuration.cache = Redis.new
   Geocoder::Configuration.cache_prefix = "..."
   Geocoder::Configuration.lookup = :yahoo
