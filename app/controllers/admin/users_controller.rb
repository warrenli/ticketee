class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all(:order => "email")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.admin = params[:user][:admin] == "1"
    if @user.save
      flash[:notice] = t("admin_user.created_msg")
      redirect_to admin_users_path
    else
      flash[:alert] = t("admin_user.not_created_msg")
      render :action => "new"
    end
  end
end
