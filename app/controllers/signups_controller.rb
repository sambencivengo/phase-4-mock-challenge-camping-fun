class SignupsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response


  def create
    signup = Signup.create!(signup_params)
    render json: signup.activity, status: :created
  end

  def show
    signup = find_signup
    render json: signup
  end

  private

  def find_signup
    Signup.find(params[:id])    
  end

  def signup_params
    params.permit(:time, :camper_id, :activity_id)
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: ["validation errors"] }, status: :unprocessable_entity
  end
  # def render_not_found_response
  #   render json: { errors: "Signup not found"}, status: :unprocessable_entity
  # end
  
end