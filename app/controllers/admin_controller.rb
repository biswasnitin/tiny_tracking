class AdminController < UsersController


  def new
    @user = User.new
    #    @user = User.find(:all)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url,:notice => "signed up!"
    else
      render "new"
    end

  end

  def show


  end


  def check_availability
    email = params[:email]
    @user = User.find_by_email(email)
    @status =  @user.blank? ? 'Available' : 'Not Available'

  end

  private
  def user_params
    params.require(:user).permit(:email,:password,:password_confirmation,:name)
  end
end
