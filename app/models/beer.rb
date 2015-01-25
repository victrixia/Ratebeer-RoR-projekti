class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def average_rating

    a = Array.new

    self.ratings.each do |rating|
      a << rating.score
    end

   a.inject{|sum, n| sum + n}/a.count

  end

  def to_s
    "#{self.name}, #{self.brewery.name}"
  end

end

