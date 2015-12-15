class DashboardsController < ApplicationController
  require 'json'
  require 'net/http'

  before_action :set_dashboard, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:opta_stats]

  # GET /dashboards
  # GET /dashboards.json
  def index
    @dashboards = []
  end

  def opta_stats
    puts '#'*80
    puts 'Post resquest params:', params.inspect
    puts '-'*80
    _xml = Net::HTTP.get_response(URI.parse('http://www.optasports.com/media/577563/srml-8-2013-results-mid-season-.xml')).body
    _json = JSON.parse(Hash.from_xml(_xml).to_json)
    puts _json
    puts '#'*80
    render json: { message: 'Done', data: _json }
  end

  # GET /dashboards/1
  # GET /dashboards/1.json
  def show
  end

  # GET /dashboards/new
  def new
    @dashboard = Dashboard.new
  end

  # GET /dashboards/1/edit
  def edit
  end

  # POST /dashboards
  # POST /dashboards.json
  def create
    @dashboard = Dashboard.new(dashboard_params)

    respond_to do |format|
      if @dashboard.save
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully created.' }
        format.json { render :show, status: :created, location: @dashboard }
      else
        format.html { render :new }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dashboards/1
  # PATCH/PUT /dashboards/1.json
  def update
    respond_to do |format|
      if @dashboard.update(dashboard_params)
        format.html { redirect_to @dashboard, notice: 'Dashboard was successfully updated.' }
        format.json { render :show, status: :ok, location: @dashboard }
      else
        format.html { render :edit }
        format.json { render json: @dashboard.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dashboards/1
  # DELETE /dashboards/1.json
  def destroy
    @dashboard.destroy
    respond_to do |format|
      format.html { redirect_to dashboards_url, notice: 'Dashboard was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dashboard
      @dashboard = Dashboard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dashboard_params
      params[:dashboard]
    end
end
