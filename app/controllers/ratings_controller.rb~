class RatingsController < ApplicationController

  def index
    @ratings = Rating.all
  end

   def new
     @rating = Rating.new
     @beer = Beer.all
   end

   def create
     Rating.create score: params.require(:rating).permit(:score, :beer_id)

    redirect_to ratings_path
   end

end
