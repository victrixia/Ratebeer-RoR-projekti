class Style < ActiveRecord::Base
  include RatingAverage
  has_many :beers
  has_many :ratings, through: :beers

  def self.top_styles(n)
    top_styles_a = Style.all.sort_by{|s| -(s.average_rating)}
    return top_styles_a.take 3
  end


end
