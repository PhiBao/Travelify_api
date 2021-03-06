class ApplicationController < ActionController::API
  def secret
    ENV['SECRET_KEY_BASE']
  end

  def encode(payload)
    JWT.encode(payload, secret, 'HS256')
  end

  def decode(token)
    JWT.decode(token, secret, true, { algorithm: 'HS256' })[0]
  end

  def load_user_by_email
    email = params[:user][:email]
    if email.blank?
      render json: { messages: ['The email address is not present'] }, status: 404
    else
      @user = User.find_by_email!(email.downcase)
    end
  rescue ActiveRecord::RecordNotFound
    render json: { messages: ['The email address is not found. Please type another one'] }, status: 404
  end

  def load_user_by_id
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { messages: ['User not found'] }, status: 404
  end

  def current_user
    token = request.headers['Authenticate']
    return if token == 'undefined'
    current_user = User.find(decode(token)['id'])
  rescue ActiveRecord::RecordNotFound
    render json: { messages: ['You are not authenticated'] }, status: 401
  end

  def logged_in_user
    unless !current_user.nil?
      render json: { messages: ['You need to login'] }, status: 403
    end
  end

  def correct_user
    @user = User.find(params[:id])
    unless current_user&.admin? || current_user == @user
      render json: { messages: ['You don\'t have permission to access this'] }, status: 403
    end
  rescue ActiveRecord::RecordNotFound
    render json: { messages: ['User not found'] }, status: 404
  end

  def admin_user
    unless current_user&.admin?
      render json: { messages: ['You do not have the right to do this action'] }, status: 401
    end
  end
end
