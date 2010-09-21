class ProjectsController < ApplicationController
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
    @project = Project.find(params[:id])
  end
end
