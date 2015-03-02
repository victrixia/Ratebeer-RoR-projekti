require 'rails_helper'

require 'rails_helper'

describe "beerlist page" do

  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost:true)
  end

  before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start

    @brewery1 = FactoryGirl.create(:brewery, name: "Koff")
    @brewery2 = FactoryGirl.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryGirl.create(:brewery, name: "Ayinger")
    @style1 = Style.create name: "Lager"
    @style2 = Style.create name: "Rauchbier"
    @style3 = Style.create name: "Weizen"
    @beer1 = FactoryGirl.create(:beer, name: "Nikolai", brewery: @brewery1, style: @style1)
    @beer2 = FactoryGirl.create(:beer, name: "Fastenbier", brewery: @brewery2, style: @style2)
    @beer3 = FactoryGirl.create(:beer, name: "Lechte Weisse", brewery: @brewery3, style: @style3)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

  it "shows one known beer", js: true do
    visit beerlist_path

    find('table').find('tr:nth-child(2)')
    # save_and_open_page
    expect(page).to have_content "Nikolai"
  end

  it "lists beers in alphabetical order", js:true do
    visit beerlist_path

    row= find('table').find('tr:nth-child(2)')
    expect(row).to have_content "Fastenbier"

    row2=find('table').find('tr:nth-child(3)')
    expect(row2).to have_content "Lechte Weisse"


    row3 = find('table').find('tr:nth-child(4)')
    expect(row3).to have_content "Nikolai"


  end

  it "when clicking style lists beers in alphabetical order by style", js:true do
    visit beerlist_path

    click_link "Style"

    row= find('table').find('tr:nth-child(2)')
    expect(row).to have_content "Lager"

    row2=find('table').find('tr:nth-child(3)')
    expect(row2).to have_content "Rauchbier"


    row3 = find('table').find('tr:nth-child(4)')
    expect(row3).to have_content "Weizen"
  end

  it "when clicking brewery lists beers in alphabetical order by brewery", js:true do
    visit beerlist_path

    click_link "Brewery"

    row1 = find('table').find('tr:nth-child(2)')
    expect(row1).to have_content "Ayinger"

    row2=find('table').find('tr:nth-child(3)')
    expect(row2).to have_content "Koff"


    row3 = find('table').find('tr:nth-child(4)')
    expect(row3).to have_content "Schlenkerla"
  end
end
