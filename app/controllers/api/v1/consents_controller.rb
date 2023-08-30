class Api::V1::ConsentsController < ApplicationController

  before_action :no_cache
  before_action :set_property

  def capture
    consent = @property.consents.new
    consent.preferences = params.require(:preferences)
    consent.country = params.require(:country).downcase
    consent.language = params.require(:language).downcase
    consent.visit_id = params.require(:visit_id)
    consent.user_type = params[:ut] if params[:ut]
    consent.save!

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
