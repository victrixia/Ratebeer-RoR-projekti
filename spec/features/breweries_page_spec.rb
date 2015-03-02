require 'rails_helper'

describe "Breweries page" do
  it "should not have any before been created" do
    visit breweries_path
    expect(page).to have_content 'Listing Breweries'
    expect(page).to have_content 'Number of breweries: 0'
    save_and_open_page
  end

  describe "when breweries exist" do

    before :each do

      @active_breweries = ["Koff", "Karjala", "Schlenkerla"]
      year = 1896
      @active_breweries.each do |brewery_name|
        FactoryGirl.create(:brewery, name: brewery_name, year: year += 1)
      end

      visit breweries_path
    end

    it "lists the existing breweries and their total number" do

      expect(page).to have_content "Number of breweries: #{@active_breweries.count}"

      @active_breweries.each do |brewery_name|
        expect(page).to have_content brewery_name
      end

    end

    it "allows user to navigate to page of a Brewery" do

      click_link "Koff"

      expect(page).to have_content "Koff"
      expect(page).to have_content "Established in 1897"

    end
  end
end