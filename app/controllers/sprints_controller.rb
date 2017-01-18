class SprintsController < ApplicationController
  def index
    @sprint = user_sprints.all
  end

  def show
    @sprint = user_sprints.find(params[:id])
  end

  def new
    @sprint = user_sprints.new
  end

  def edit
    @sprint = user_sprints.find(params[:id])
  end

  def create
    @sprint = user_sprints.create(sprint_params)

    if @sprint.valid?
      redirect_to user_sprint_path(id: @sprint.id)
    else
      render 'new'
    end
  end

  def update
    @sprint = user_sprints.find(params[:id])

    if @sprint.update(sprint_params)
      redirect_to user_sprint_path(id: @sprint.id)
    else
      render 'edit'
    end
  end

  def destroy
    @sprint = user_sprints.find(params[:id])
    @sprint.destroy

    redirect_to user_sprints_path
  end

  private

  def user_sprints
    current_user.sprints
  end

  def sprint_params
    params.require(:sprint).permit(:id, :title, :start_date, :end_date)
  end
end
