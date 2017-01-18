class FeaturesController < ApplicationController
  def index
    @feature = sprint_features.all
  end

  def show
    @feature = sprint_features.find(params[:id])
  end

  def new
    @feature = sprint_features.new
  end

  def edit
    @feature = sprint_features.find(params[:id])
  end

  def create
    @feature = sprint_features.create(feature_params)

    if @feature.valid?
      redirect_to user_sprint_feature_path(id: @feature.id)
    else
      render 'new'
    end
  end

  def update
    @feature = sprint_features.find(params[:id])

    if @feature.update(feature_params)
      redirect_to user_sprint_feature_path(id: @feature.id)
    else
      render 'edit'
    end
  end

  def destroy
    @feature = sprint_features.find(params[:id])
    @feature.destroy

    redirect_to user_sprint_features_path
  end

  private

  def sprint
    @current_sprint ||= Sprint.find_by(id: params[:sprint_id])
  end

  def sprint_features
    sprint.features
  end

  def feature_params
    params.require(:feature).permit(:id,
                                    :title,
                                    :rank,
                                    :estimated_total_hours,
                                    :estimated_remaining_hours,
                                    :actual_worked_hours)
  end
end
