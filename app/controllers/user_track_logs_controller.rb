class UserTrackLogsController < ApplicationController
  before_action :set_user_track_log, only: [:edit, :update, :destroy]

   before_action :redirect_to_login,except:[:create]

  # GET /user_track_logs
  # GET /user_track_logs.json
  def index
    @date = Date.parse(params[:date]) rescue Date.today
    @late_users_count = UserTrackLog.where('DATE(arrival_time) = ? and is_late = 1', @date).count
   # @avg_time = UserTrackLog.find_by_sql("select user_name,AVG(DATE_FORMAT(arrival_time,'%H:%i:%s')) 'av_time',user_id from user_track_logs where DATE(arrival_time) = '#{@date}'")

    @user_track_logs = UserTrackLog.find_by_sql(" select u.id,u.user_name,arrival_time,is_late,u.user_id,t.late_count from user_track_logs u 
                                                  left outer join (select user_name,SUM(is_late :: int) 'late_count',user_id
                                                 from user_track_logs group by user_name,user_id) t  on (u.user_id =t.user_id)
                                                   where DATE(u.arrival_time) = '#{@date}' order by u.user_name asc, t.late_count desc")



    deliver_at =  @user_track_logs.map{|d| d.arrival_time.hour * 3600 + d.arrival_time.min * 60 + d.arrival_time.sec}
    avg =deliver_at.inject(:+) / deliver_at.count unless deliver_at.blank?
    avg_hour = avg / 3600 if avg
    avg_minut = (avg % 3600) / 60 if avg
    avg_sec = avg % 60 if avg

    @avg_time = "#{avg_hour}:#{avg_minut}:#{avg_sec}" if avg



  end

  # GET /user_track_logs/1
  # GET /user_track_logs/1.json
  def show

    @late_users_count = UserTrackLog.where(' is_late = 1 and user_id = ?',params[:id]).count
    #@avg_time = UserTrackLog.find_by_sql("select user_name,AVG(DATE_FORMAT(arrival_time,'%H:%i:%s')) 'av_time',user_id from user_track_logs  where user_id = '#{params[:id]}'")

    @user_track_logs = UserTrackLog.find_by_sql(" select u.id,u.user_name,arrival_time,is_late,u.user_id from user_track_logs u 
                                                  
                                                   where u.user_id = '#{params[:id]}' order by arrival_time desc")
 
    deliver_at =  @user_track_logs.map{|d| d.arrival_time.hour * 3600 + d.arrival_time.min * 60 + d.arrival_time.sec}
    avg =deliver_at.inject(:+) / deliver_at.count unless deliver_at.blank?
    avg_hour = avg / 3600 if avg
    avg_minut = (avg % 3600) / 60 if avg
    avg_sec = avg % 60 if avg
    @avg_time = "#{avg_hour}:#{avg_minut}:#{avg_sec}" if avg

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
    
    @user = User.find_by_name(params[:user_track_log][:user_name])
    if @user.blank?
      redirect_to root_url, notice: 'Invalid User Name.' 
      return
    end
    
    user_logged_in = UserTrackLog.where('DATE(arrival_time) = ? and user_name = ?', Date.today,params[:user_track_log][:user_name])
    unless user_logged_in.blank?
      redirect_to root_url, notice: 'You have Already Signed in'
       return
    end
    @user_track_log = UserTrackLog.new(user_track_log_params)
    @user_track_log.arrival_time = Time.now 
    @user_track_log.is_late = (Time.now > Time.now.beginning_of_day + 10.hours) ? 1 : 0
    @user_track_log.user_id  =  @user.id


     if (@user_track_log.is_late == 1)
      message = "Hello #{params[:user_track_log][:user_name]} you are late today please sing in before 10 AM"
    else
      message = "Hello #{params[:user_track_log][:user_name]} you have singned in successfully"
     end
    respond_to do |format|
      if @user_track_log.save
        format.html { redirect_to root_url, notice: "#{message}" }
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
