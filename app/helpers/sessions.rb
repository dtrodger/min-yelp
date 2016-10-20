helpers do
  def auth_user
    @auth_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    true if auth_user
  end

  def authenticate!
    redirect '/users/new' unless logged_in?
  end

  def view_owner?(obj)
    true if obj.owner == auth_user && logged_in?
  end

  def route_owner?(obj)
    authenticate!
    redirect '/404' unless obj.owner == auth_user
  end
end
