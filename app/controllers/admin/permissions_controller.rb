class Admin::PermissionsController < ApplicationController
  before_filter :find_user

  def index
    @ability = Ability.new(@user)
    @projects = Project.all
  end

  def update
    @user.permissions.clear
    params[:permissions].each do |id, permissions|
      project = Project.find(id)
      permissions.each do |permission, checked|
        Permission.create!(:user => @user, :object => project, :action => permission)
      end
    end
    flash[:notice] = t("admin_permission.updated_msg")
    redirect_to admin_user_permissions_path
  end

  private

    def find_user
      @user = User.find(params[:user_id])
    end
end
