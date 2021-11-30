class ActivitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  # rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index
    activities = Activity.all
    render json: activities
  end

  def destroy
    activity = find_activity
    activity.signups.each {|signup| signup.destroy}
    activity.destroy
    render json: {}
  end

    
  # def show
  #   activity = find_activity
  #   render json: activity
  # end




  private

  def find_activity
    Activity.find(params[:id])    
  end

  def activity_params
    params.permit(:name, :difficulty)
  end

  def render_not_found_response
    render json: { error: "Activity not found"}, status: :not_found
  end

  # def render_unprocessable_entity_response(invalid)
  #   render json: { errors: invalid.record.errors }, status: :unprocessable_entity
  # end
end