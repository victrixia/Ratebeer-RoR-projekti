class RatingsController < ApplicationController

  def index

    # eeeehm kai tää toimii? Ainakin vähän? En oikein saa top_usersista karsittua jostain syystä noita kyselyitä, mutta ainakaan tässä ei enää mene 10 sekuntia per lataus...

    @ratings = Rails.cache.read "all"
    # @recent = Rating.order(created_at: :desc).limit(5)

    @recent = Rails.cache.read "recent"
    @top_breweries = Rails.cache.read "brewery top 3"

    @top_beers = Rails.cache.read "beer top 3"
    @top_users = Rails.cache.read "top users"
    @top_styles = Rails.cache.read "top styles"
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  # def destroy_orphans
  # @ratings.each do |rating|
  #   if rating.user_id.nil?
  #     rating.delete
  #  end
  #end
  # end

  def destroy
    rating = Rating.find(params[:id])

    rating.delete if current_user == rating.user
    redirect_to :back
  end

  def create
    @rating = Rating.create params.require(:rating).permit(:score, :beer_id)

    if current_user.nil?
      redirect_to signin_path, notice: 'you should be signed in!'

    elsif @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user

    else
      @beers = Beer.all
      render :new
    end
    # talletetaan tehdyn reittauksen sessioon joo kyllä copypastesin
    # session[:last_rating] = "#{rating.beer.name} #{rating.score} points"

    # redirect_to ratings_path
  end

  private

  def update_cache_in_background
    while true do
      sleep 10.minutes
      Rails.cache.write("all", Rating.includes(:beer, :user).all)
      Rails.cache.write("recent", @ratings.recent)
      Rails.cache.write("brewery top 3", Brewery.includes(:beers, :ratings).top(3))
      Rails.cache.write("beer top 3", Beer.includes(:brewery, :style).top(3))
      Rails.cache.write("top users", User.includes(:ratings, :beers).users_with_most_ratings(3))
      Rails.cache.write("top styles", Style.includes(:beers, :ratings).top_styles(3))

    end
  end


end
