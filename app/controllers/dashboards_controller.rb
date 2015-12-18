class DashboardsController < ApplicationController
  require 'json'
  require 'net/http'
  require 'nokogiri'

  before_action :set_dashboard, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:opta_stats]

  # GET /dashboards
  # GET /dashboards.json
  def index
    @success_msg = nil
    return unless params['post_req_to_opta_stats']
    begin
      Net::HTTP.post_form(
        URI.parse('http://localhost:3000/opta_stats.json'),
        xml_data: SAMPLE_OPTA_RESULTS_FEED_XML)
    rescue Net::ReadTimeout
      nil
    end
    @success_msg = 'Done! POST Request Completed for opta_stats API.'
  end

  def opta_stats
    puts '#' * 80
    puts '******************** Received post request ********************'

    # Read XML data from request body and pasrto JSON
    # curl -X POST -d @results.xml http://localhost:3000/opta_stats.json
    xml_data = params['xml_data'] ? params['xml_data'] : request.body

    # The only reason to use Nokogiri is - handle character '&' in XML
    parsed_xml_data = Nokogiri::XML(xml_data)

    json_data = JSON.parse(Hash.from_xml(parsed_xml_data.to_s).to_json)
    puts '******************** Parsed JSON ********************', json_data
    converted_json = convert_hash_keys(json_data)
    puts '================== Converted JSON ==================', converted_json
    save_opta_stats(converted_json)
    puts '#' * 80
    render json: { message: 'Done' }
  end

  def convert_hash_keys(value)
    case value
    when Array
      value.map { |v| convert_hash_keys(v) }
    when Hash
      Hash[value.map { |k, v| [underscore_key(k), convert_hash_keys(v)] }]
    else
      value
    end
  end

  def underscore_key(k)
    k.to_s.underscore
  end

  def save_opta_stats(json_data)
    json_data = json_data['soccer_feed']['soccer_document']
    if json_data['type'] == RESULTS_FEED_TYPE
      puts '-' * 80, RESULTS_FEED_TYPE
      # Create record in DB for result_feeds
    elsif json_data['type'] == STANDINGS_FEED_TYPE
      puts '-' * 80, STANDINGS_FEED_TYPE
      # Create record in DB for standing_feeds
    end
  end
end
