class Api::V1::ImpressionsController < ApplicationController

  before_action :set_property
  before_action :no_cache, only: :capture

  def capture
    impression = @property.impressions.new
    impression.country = params.require(:country).downcase
    impression.language = params.require(:language).downcase
    impression.visit_id = params.require(:visit_id)
    impression.user_type = params[:ut] if params[:ut]
    impression.save!

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
