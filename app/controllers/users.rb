get '/users/new' do
  erb :'users/new'
end

post '/users' do
  user = User.new(params[:user])
  if user.save
    session[:user_id] = user.id
    redirect '/restaurants'
  else
    @errors = user.errors.full_messages
    erb :'users/new'
  end
end

# get '/users/:id' do
#   if logged_in?
#     erb :'users/show'
#   end
# end
