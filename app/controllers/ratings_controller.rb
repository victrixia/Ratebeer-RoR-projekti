class RatingsController < ApplicationController

  def index
    @ratings = Rating.all
    # @recent = Rating.order(created_at: :desc).limit(5)
    @recent = Rating.recent
    @top_breweries = Brewery.top(3)
    @top_beers = Beer.top(3)
    @top_users = User.users_with_most_ratings(3)
    @top_styles = Style.top_styles(3)
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

end
