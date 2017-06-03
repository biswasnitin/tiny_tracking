class UserTrackLogsController < ApplicationController
  before_action :set_user_track_log, only: [:show, :edit, :update, :destroy]

  # GET /user_track_logs
  # GET /user_track_logs.json
  def index
    @user_track_logs = UserTrackLog.all
  end

  # GET /user_track_logs/1
  # GET /user_track_logs/1.json
  def show
  end

  # GET /user_track_logs/new
  def new
    @user_track_log = UserTrackLog.new
  end

  # GET /user_track_logs/1/edit
  def edit
  end

  # POST /user_track_logs
  # POST /user_track_logs.json
  def create
    @user_track_log = UserTrackLog.new(user_track_log_params)

    respond_to do |format|
      if @user_track_log.save
        format.html { redirect_to @user_track_log, notice: 'User track log was successfully created.' }
        format.json { render :show, status: :created, location: @user_track_log }
      else
        format.html { render :new }
        format.json { render json: @user_track_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_track_logs/1
  # PATCH/PUT /user_track_logs/1.json
  def update
    respond_to do |format|
      if @user_track_log.update(user_track_log_params)
        format.html { redirect_to @user_track_log, notice: 'User track log was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_track_log }
      else
        format.html { render :edit }
        format.json { render json: @user_track_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_track_logs/1
  # DELETE /user_track_logs/1.json
  def destroy
    @user_track_log.destroy
    respond_to do |format|
      format.html { redirect_to user_track_logs_url, notice: 'User track log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_track_log
      @user_track_log = UserTrackLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_track_log_params
      params.require(:user_track_log).permit(:user_id, :user_name)
    end
end
