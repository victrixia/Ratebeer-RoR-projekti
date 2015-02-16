require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown on the page" do

    create_bar_in_location("kumpula", 'Oljenkorsi')
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "Shows all returned places if more than one is returned by API" do
    @places = ['Kukkaruukku', 'Kalmisto', 'Prkl']
    create_bars_in_location('kumpula')
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"


    @places.each do |place|
      expect(page).to have_content place
    end


  end

  it "notifies the user if no places were found in given location" do
    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"
  end

  def create_bar_in_location(place, barname)
    allow(BeermappingApi).to receive(:places_in).with(place).and_return(
                                 [Place.new(name: barname, id:1)]
                             )

  end

  def create_bars_in_location(place)
    allow(BeermappingApi).to receive(:places_in).with(place).and_return(
                                 [Place.new(name: 'Kukkaruukku', id:1), Place.new(name:'Kalmisto', id:2), Place.new(name:'Prkl', id:3)]
                             )
  end

  # def create_bars_in_location(*barnames, place)
  #   barnames.each do |barname|
  #     create_bar_in_location(place, barname)
  #   end
  # end
end

