require 'rails_helper'


describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name: "iso 3", brewery: brewery }
  let!(:beer2) { FactoryGirl.create :beer, name: "Karhu", brewery: brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    visit sign_in(username: "Pekka", password: "Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect {
      click_button "Create Rating"
    }.to change { Rating.count }.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  describe "when user has ratings" do

    before :each do


      @ratings = [10, 20, 30, 40]

      @ratings.each do |score|
        FactoryGirl.create(:rating, score: score, beer: beer1, user: user)
      end

    end

    it "lists existing ratings and counts them" do

      visit ratings_path
      save_and_open_page
      expect(page).to have_content "Number of ratings #{Rating.count}"

      @ratings.each do |score|
        expect(page).to have_content score
      end

    end

    it "user's page lists user's own ratings and no others" do

      paivi = FactoryGirl.create(:user, username: "Päivi")
      FactoryGirl.create(:rating, beer: beer2, user: paivi)

      visit user_path(user)

      expect(page).to have_content "Has made #{user.ratings.count} ratings"

      @ratings.each do |score|
        expect(page).to have_content score
      end

      expect(page).not_to have_content "Karhu"


    end

    it "deletes rating from DB if user removes rating" do

      visit user_path(user)
      i = Rating.count

      click_link('delete', :match => :first)

      expect(Rating.count).to eq(i-1)

    end
  end
end
