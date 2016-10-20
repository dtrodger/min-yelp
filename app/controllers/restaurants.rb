get '/restaurants' do
  @restaurants = Restaurant.all
  erb :'restaurants/index'
end

post '/restaurants' do
  authenticate!

  params[:restaurant][:owner] = auth_user

  restaurant = Restaurant.new(params[:restaurant])

  if restaurant.save
    redirect "/restaurants/#{ restaurant.id }"
  else
    @errors = restaurant.errors.full_messages

    erb :'restaurants/new'
  end
end

get '/restaurants/new' do
  authenticate!
  if request.xhr?
    erb :'restaurants/new', layout: false
  else
    erb :'restaurants/new'
  end
end

get '/restaurants/:id/edit' do
  restaurant = Restaurant.find_by(id: params[:id])
  route_owner?(restaurant)
  @edit = restaurant.attributes
  erb :'restaurants/edit'
end

put '/restaurants/:id' do
  restaurant = Restaurant.find_by(id: params[:id])
  route_owner?(restaurant)

  restaurant.update_attributes(params[:restaurant])

  redirect "/restaurants/#{ restaurant.id }"
end

delete '/restaurants/:id' do
  restaurant = Restaurant.find_by(id: params[:id])
  route_owner?(restaurant)

  restaurant.destroy

  if request.xhr?
    status 200
  else
    redirect '/restaurants'
  end
end

get '/restaurants/:id' do
  @restaurant = Restaurant.find_by(id: params[:id])

  erb :'restaurants/show'
end

