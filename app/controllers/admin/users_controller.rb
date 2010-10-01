class Admin::UsersController < Admin::BaseController
  before_filter :find_user, :only => [:show, :edit, :update, :destroy]

  def index
    @users = User.all(:order => "email")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    set_admin
    if @user.save
      flash[:notice] = t("admin_user.created_msg")
      redirect_to admin_users_path
    else
      flash[:alert] = t("admin_user.not_created_msg")
      render :action => "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    set_admin
    if @user.update_attributes(params[:user])
      flash[:notice] = t("admin_user.updated_msg")
      redirect_to admin_users_path
    else
      flash[:alert] = t("admin_user.not_updated_msg")
      render :action => "edit"
    end
  end

  def destroy
    if @user == current_user
      flash[:alert] = t("admin_user.not_self_deleted_msg")
    else
      @user.destroy
      flash[:notice] = t("admin_user.deleted_msg")
    end
      redirect_to admin_users_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def set_admin
    @user.admin = params[:user][:admin] == "1"
  end
end
