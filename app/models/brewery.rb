class Brewery < ActiveRecord::Base

  include RatingAverage

  validates :name, length: {minimum: 1}
  validates :year,  numericality: { greater_than_or_equal_to: 1042,
                                    less_than_or_equal_to: Proc.new{Time.now.year},
                                    only_integer: true }
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  scope :active, -> {where active:true}
  scope :inactive, -> {where active:[false, nil]}

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    self.year=2015
    puts "Changed year to #{year}"
  end



  #voi tehdä näin mut parempi on scope
  # def self.active
  #   Brewery.where(active:true)
  # end


end
