class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, except: %i[ index new create ]

  # GET /teams or /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1 or /teams/1.json
  def show
    @team_users = @team.users
  end

  # GET /teams/new
  def new
    @team = current_user.teams.new
  end

  # GET /teams/1/edit
  def edit
  end

  # GET /teams/1/teams_users
  def teams_users
    @users = User.where.not(id: @team.users.select(:id))
  end

  # POST /teams/1/add_users
  def add_users
    @new_users = User.where(id: params.require(:team)[:users])
    @team.users << @new_users
    @other_users = User.where.not(id: @team.users.select(:id))
    respond_to do |format|
      format.turbo_stream
    end
  end

  # DELETE /teams/1/teams_users
  def delete_user
    team_user = @team.teams_users.find_by(user_id: params[:user_id])
    @user_id = params[:user_id]
    if team_user.delete
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  # PATCH /teams/1/teams_users
  def update_admin
    team_user = @team.teams_users.find_by(user_id: params[:user_id])
    @user = User.find(params[:user_id])
    if team_user.update!(admin: params[:admin])
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  # POST /teams or /teams.json
  def create
    @team = current_user.teams.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to team_url(@team), notice: "Team was successfully created." }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1 or /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to team_url(@team), notice: "Team was successfully updated." }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1 or /teams/1.json
  def destroy
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url, notice: "Team was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.require(:team).permit(:name, :user_id)
    end
end
