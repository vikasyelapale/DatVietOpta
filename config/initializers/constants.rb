SAMPLE_OPTA_RESULTS_FEED_URL = 'http://www.optasports.com/media/577560/srml-5-2013-results-group-competition-.xml'
SAMPLE_OPTA_STANDINGS_FEED_URL = 'http://www.optasports.com/media/578360/srml-5-2013-standings-group-competition-.xml'

RESULTS_FEED_TYPE = 'RESULTS Latest'
STANDINGS_FEED_TYPE = 'STANDINGS Latest'

MSG = 'Want to send POST Request explicitly to opta_stats API with XML Data. Click on link \'Send Post Request\' and have look at rails log.'

SAMPLE_OPTA_RESULTS_FEED_XML = Net::HTTP.get_response(URI.parse(SAMPLE_OPTA_RESULTS_FEED_URL)).body
SAMPLE_OPTA_STANDINGS_FEED_XML = Net::HTTP.get_response(URI.parse(SAMPLE_OPTA_STANDINGS_FEED_URL)).body