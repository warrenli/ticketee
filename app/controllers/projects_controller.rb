class ProjectsController < ApplicationController
  before_filter :authorize_admin!, :except => [:index, :show]
  before_filter :authenticate_user!, :only => [:show]
  before_filter :find_project, :only => [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      flash[:notice] = t("projects.created_msg")
      redirect_to @project
    else
      flash[:alert] = t("projects.not_created_msg")
      render :action => "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = t("projects.updated_msg")
      redirect_to @project
    else
      flash[:alert] = t("projects.not_updated_msg")
      render :action => "edit"
    end
  end

  def destroy
    @project.destroy
    flash[:notice] = t("projects.deleted_msg")
    redirect_to projects_path
  end

  private
    def find_project
      @project = if current_user.admin?
        Project.find(params[:id])
      else
        Project.readable_by(current_user).find(params[:id])
      end
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t("projects.not_found_msg")
      redirect_to projects_path
    end
end
