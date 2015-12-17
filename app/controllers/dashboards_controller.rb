class DashboardsController < ApplicationController
  require 'json'
  require 'net/http'

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
    xml_data = params['xml_data'] ? params['xml_data'] : SAMPLE_OPTA_RESULTS_FEED_XML
    puts '#' * 80
    puts '******************** Received post request ********************'
    json_data = JSON.parse(Hash.from_xml(xml_data).to_json)
    puts '******************** Parsed JSON ********************', json_data
    save_opta_stats(json_data)
    puts '#' * 80
    render json: { message: 'Done' }
  end

  def save_opta_stats(json_data)
    json_data = json_data['SoccerFeed']['SoccerDocument']
    if json_data['Type'] == RESULTS_FEED_TYPE
      puts '-' * 80, RESULTS_FEED_TYPE
      # Create record in DB for result_feeds
    elsif json_data['Type'] == STANDINGS_FEED_TYPE
      puts '-' * 80, STANDINGS_FEED_TYPE
      # Create record in DB for standing_feeds
    end
  end
end
