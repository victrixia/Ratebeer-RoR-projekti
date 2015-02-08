require 'rails_helper'

describe "Beer page" do
  let!(:user){FactoryGirl.create :user}
  let!(:brewery){FactoryGirl.create :brewery}


  describe "when user is signed in" do

    before :each do
      visit sign_in(username: "Pekka", password: "Foobar1")
    end

    it "is possible to create a beer through the website when beer has valid name" do
      visit new_beer_path

      fill_in('beer_name', with: 'Lahden Sininen')
      select('Lager', from: 'beer[style]')
      select('anonymous', from: 'beer[brewery_id]')

      expect{
        click_button "Create Beer"
      }.to change{Beer.count}.from(0).to(1)


    end

    it "returns to create new beer if name is not valid and the beer isn't saved" do
      visit new_beer_path

      select('Lager', from: 'beer[style]')
      select('anonymous', from: 'beer[brewery_id]')

      click_button "Create Beer"

      expect(page).to have_content 'New Beer'
      expect(page).to have_content 'Name is too short (minimum is 1 character)'
      expect(Beer.count).to eq (0)
    end
  end
end