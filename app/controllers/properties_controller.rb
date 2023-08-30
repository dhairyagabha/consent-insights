class PropertiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_property, except: %i[ index new create]

  # GET /properties or /properties.json
  def index
    @properties = policy_scope(Property)
    @properties = @properties.nil? ? @properties : @properties.uniq
  end

  # GET /properties/1 or /properties/1.json
  def show
  end

  def global_visits
    range = Time.current.all_day
    if params[:start_date] && params[:end_date]
      range = Date.new(params[:start_date])..Date.new(params[:end_date])
    end
    @visits = @property.visits.where(user_type: "NEW").group_by_day(:created_at).count
    @impressions = @property.impressions.where(user_type: "NEW").group_by_day(:created_at).count
    @consents = @property.consents.where(user_type: "NEW").group_by_day(:created_at).count
  end
  
  def required_optin
    range = Time.current.all_day
    if params[:start_date] && params[:end_date]
      range = Date.new(params[:start_date])..Date.new(params[:end_date])
    end
    @required = @property.consents.where('user_type = ? AND preferences LIKE ?', 'NEW', '%0%').count
    @impressions = @property.impressions.where(user_type: "NEW").count
  end

  def functional_optin
    range = Time.current.all_day
    if params[:start_date] && params[:end_date]
      range = Date.new(params[:start_date])..Date.new(params[:end_date])
    end
    @functional = @property.consents.where('user_type = ? AND preferences LIKE ?', 'NEW', '%1%').count
    @impressions = @property.impressions.where(user_type: "NEW").count
  end

  def advertising_optin
    range = Time.current.all_day
    if params[:start_date] && params[:end_date]
      range = Date.new(params[:start_date])..Date.new(params[:end_date])
    end
    @advertising = @property.consents.where('user_type = ? AND preferences LIKE ?', 'NEW', '%2%').count
    @impressions = @property.impressions.where(user_type: "NEW").count
  end

  def bounce
    range = Time.current.all_day
    if params[:start_date] && params[:end_date]
      range = Date.new(params[:start_date])..Date.new(params[:end_date])
    end
    @impressions = @property.impressions.count
    @required = @property.consents.where(user_type: "NEW").where('user_type = ? AND preferences LIKE ?', 'NEW', '%0%').count
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties or /properties.json
  def create
    @property = Property.new(property_params)

    respond_to do |format|
      if @property.save
        format.html { redirect_to property_url(@property), notice: "Property was successfully created." }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1 or /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to property_url(@property), notice: "Property was successfully updated." }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1 or /properties/1.json
  def destroy
    @property.destroy

    respond_to do |format|
      format.html { redirect_to properties_url, notice: "Property was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = policy_scope(Property).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def property_params
      params.require(:property).permit(:name, :domain)
    end
end
