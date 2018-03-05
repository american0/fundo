class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def new
    @foundation = Foundation.find(params[:id])
    @project = Project.new
  end

  def create
    @project = Project.new(
                title: project_params[:title],
                funding_goal: project_params[:funding_goal],
                start_date: project_params[:start_date],
                end_date: project_params[:end_date],
                short_description: project_params[:short_description],
                full_description: project_params[:full_description],
                foundation_id: params[:id],
                project_owner_id: current_user.id
              )


    if @project.save
      flash[:success] = "Your project has been created!"
      redirect_to foundation_path(@project.foundation)
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  private


  def project_params
    params.require(:project).permit(:foundation, :currency, :title, :funding_goal, :short_description, :full_description, :start_date, :end_date)
  end
end

