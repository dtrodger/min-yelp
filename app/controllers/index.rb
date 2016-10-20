get '/' do
 redirect '/restaurants'
end

get '/404' do
  erb :'404'
end
