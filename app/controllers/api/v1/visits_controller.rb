class Api::V1::VisitsController < ApplicationController
	
  before_action :set_property
  before_action :no_cache, only: :capture

  def capture
    visit = @property.visits.new
    visit.country = params.require(:country).downcase
    visit.language = params.require(:language).downcase
    visit.visit_id = params.require(:visit_id)
    visit.user_type = params[:ut] if params[:ut]
    visit.title = params[:title] if params[:title]
    visit.url = params[:url] if params[:url]
    visit.preferences = params[:preferences] if params[:preferences]
    visit.user_agent = params[:ua] if params[:ua]
    visit.save!

    send_data ConsentInsights::PIXEL_IMG, type: 'image/png', disposition: 'inline'
  end

  private

  def set_property
    @property = Property.find_by(api_key: params.require(:api_key), secret: params.require(:secret))
  end

  def no_cache
    request.session_options[:skip] = true
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = %w[GET POST OPTIONS].join(',')
    headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
    headers['Pragma'] = 'no-cache'
    headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end
end
