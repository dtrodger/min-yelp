get '/sessions/new' do
  erb :'sessions/new'
end

post '/sessions' do
  user = User.find_by(email: params[:user][:email])

  begin
    if user.authenticate(params[:user][:password])
      session[:user_id] = user.id

      redirect '/restaurants'
    else
      @errors = ['Invalid email or password']

      erb :'sessions/new'
    end
  rescue
    @errors = ['Invalid email or password']
    erb :'sessions/new'
  end

end

delete '/sessions' do
  session.delete(:user_id)

  redirect '/restaurants'
end
