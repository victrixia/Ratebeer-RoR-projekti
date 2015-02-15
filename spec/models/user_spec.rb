require 'rails_helper'

describe User do

  BeerClub
  BeerClubsController

  it "does not save in DB with too short a password" do
    user = User.create username: "Milla", password: "A1o"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "does not save in DB with a password consisting only of letters" do
    user = User.create username: "Kaija", password: "Mummi"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "when creating without password" do

    before :each do
      @user= User.new username: "Pekka"
    end
    it "has username set correctly" do

      expect(@user.username).to eq("Pekka")
    end

    it "is not saved without valid password" do

      expect(@user.valid?).to be(false)
      expect(User.count).to eq(0)
    end
  end

  describe "when created with valid password" do
    before :each do
      @user = FactoryGirl.create(:user)
    end


    it "increases the num of users in DB" do
      expect(@user.valid?).to eq(true)
      expect(User.count).to eq(1)
    end

    it "has correct name in DB" do
      expect(User.first.username).to eq("Pekka")
    end

    it "has correct average rating with two ratings" do
      #br = Brewery.create name: "Koff"
      #beer1 = Beer.create name: "karhu", style: "Lager", brewery: br
      #beer2 = Beer.create name: "iso 3", style: "Lager", brewery: br

      @user.ratings << FactoryGirl.create(:rating)
      @user.ratings << FactoryGirl.create(:rating2)

      expect(@user.ratings.count).to eq(2)
      expect(@user.average_rating).to eq(15.0)

    end


  end
  describe "favourite beer" do

    let(:user) { FactoryGirl.create(:user) }

    it "has method for determining the favourite_beer" do
      user.should respond_to :favourite_beer
    end

    it "without ratings does not have one" do
      expect(user.favourite_beer).to eq(nil)
    end

    it "is the only rated beer if user only has one rating" do
      beer = create_beer_with_rating(10, user)

      expect(user.favourite_beer).to eq(beer)
    end


    it "is the one with highest rating if several ratings exist" do
      create_beers_with_ratings(10, 7, 20, 9, user)
      best = create_beer_with_rating(25, user)


      expect(user.favourite_beer).to eq(best)
    end
  end

  describe "favourite style" do
    let(:user) { FactoryGirl.create(:user) }

    it "has method for determining favourite style" do
      user.should respond_to :favourite_style
    end

    it "without ratings doesn't have one" do
      expect(user.favourite_style).to eq(nil)
    end

    it "returns the only rated one if only one rating" do
      create_beer_with_rating_and_style(10, user, "Lager")

      expect(user.favourite_style).to eq("Lager")
    end

    it "returns the highest rated style if several ratings" do

      create_beer_with_rating_and_style(9, user, "Lager")
      create_beer_with_rating_and_style(20, user, "IPA")
      create_beers_with_ratings_and_styles(13, 23, 12, user, "Porter")

      expect(user.favourite_style).to eq("IPA")

    end
  end


  describe "favorite brewery" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favourite_brewery)
    end

    it "without ratings does not have one" do
      expect(user.favourite_brewery).to eq(nil)
    end

    it "is the brewery of only rated if one rating" do
      brewery = FactoryGirl.create(:brewery, name:"Koff")
      create_beers_with_ratings_and_brewery(10, brewery, user)

      expect(user.favourite_brewery).to eq(brewery)
    end

    it "is the brewery with highest average rating if several rated" do
      plevna = FactoryGirl.create(:brewery, name:"Plevna")
      create_beers_with_ratings_and_brewery(10, 20, 15, FactoryGirl.create(:brewery), user)
      create_beers_with_ratings_and_brewery(35, plevna , user)
      create_beers_with_ratings_and_brewery(25, 20, 15, FactoryGirl.create(:brewery), user)

      expect(user.favourite_brewery).to eq(plevna)
    end
  end

  def create_beer_with_rating(score, user)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score: score, beer: beer, user: user)
    beer
  end

  def create_beer_with_rating_and_style(score, user, style)
    beer = FactoryGirl.create(:beer, style: style)
    FactoryGirl.create(:rating, score: score, beer: beer, user: user)
    beer
  end

  def create_beers_with_ratings(*scores, user)
    scores.each do |score|
      create_beer_with_rating(score, user)
    end
  end

  def create_beers_with_ratings_and_styles(*scores, user, style)
    create_beers(*scores, style, Brewery.new, user)
  end

  def create_beers(*scores, style, brewery, user)

    scores.each do |score|
      create_beer(score, style, brewery, user)
    end
  end

  def create_beer(score, style, brewery, user)
    beer = FactoryGirl.create(:beer, style: style, brewery: brewery)
    FactoryGirl.create(:rating, score: score, beer: beer, user: user)
    beer
  end


  def create_beers_with_ratings_and_brewery(*scores, brewery, user)
    create_beers(*scores, "Pale Ale", brewery, user)
  end

end
