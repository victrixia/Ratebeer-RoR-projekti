class PlacesController < ApplicationController

  before_action :set_place, only: [:show]

  def index
  end

  def show
    expires_in 1.week, :public => true
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else

      render :index
    end
  end


end