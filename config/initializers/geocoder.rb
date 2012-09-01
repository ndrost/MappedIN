# caching (see below for details)
   Geocoder::Configuration.cache = Redis.new
   Geocoder::Configuration.cache_prefix = "..."
   Geocoder::Configuration.lookup = :yahoo
