post '/restaurants/:restaurant_id/comments' do
  logged_in?

  restaurant = Restaurant.find_by(id: params[:restaurant_id])

  if restaurant.owner == auth_user
    redirect "/restaurants/#{ restaurant.id }"
  else
    params[:review][:author] = auth_user

    params[:review][:restaurant] = restaurant

    review = Review.new(params[:review])

    if review.save
      redirect "/restaurants/#{ restaurant.id }"
    else
      @errors = review.errors.full_messages
      @restaurant = restaurant

      erb :'restaurants/show'
    end
  end
end
