class TweetController < ApplicationController

  get '/tweets' do
    if !session[:user_id]
      redirect "/login"
    end
    @users = User.all
    erb :"tweets/tweets"
  end

  get '/tweets/new' do
    if session[:user_id] #returns nil if there isn't one
      @user = User.find(session[:user_id])
      erb :"tweets/create_tweet"
    else
      redirect "/login"
    end
  end

  post '/tweets/new' do
    user = User.find(session[:user_id])
    if params[:content] == ""
      redirect "/tweets/new"
    end
    tweet = Tweet.create(content: params[:content], user_id: params[:user_id])
    redirect '/tweets'
  end

  post '/tweets' do
    @users = User.all
    erb :"tweets/tweets"
  end

  get '/tweets/:id' do
    if !session[:user_id]
      redirect "/login"
    end
    @tweet = Tweet.find(params[:id])
    erb :"tweets/show_tweet" #include edit link & delete button
  end

  get '/tweets/:id/edit' do
    if !session[:user_id]
      redirect "/login"
    end

    @tweet = Tweet.find(params[:id])

    if session[:user_id] != @tweet.user_id
      redirect "/tweets"
    else
      erb :"tweets/edit_tweet"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if params[:content] == ""
      redirect "/tweets/#{@tweet.id}/edit"
    end
    @tweet.update(content: params[:content])
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find(params[:id])
    if session[:user_id] != @tweet.user_id
      redirect "/tweets/#{@tweet.id}"
    end
    @tweet.destroy
    redirect "/tweets"
  end

end
