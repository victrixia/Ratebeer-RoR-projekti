require 'rails_helper'

RSpec.describe Beer, :type => :model do

  it "isn't saved in DB without a name" do
    beer = Beer.create style: "Lager"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

  it "is not saved in DB without a style" do
    beer = Beer.create name: "Aarni"

    expect(beer.valid?).to be (false)
    expect(Beer.count).to eq(0)
  end

  describe "when created with valid name and style" do
    before :each do
      @beer = Beer.create name: "Aarni", style: "Ruis IPA"
    end

    it "is saved in DB if given a name and style" do
    expect(@beer.valid?).to be (true)
    expect(Beer.count).to eq(1)
      end
  end

end
