class RatingsController < ApplicationController

  def index
    @ratings = Rating.all
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
