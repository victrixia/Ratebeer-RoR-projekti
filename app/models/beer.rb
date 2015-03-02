class Beer < ActiveRecord::Base
  include RatingAverage
  validates :name, length: {minimum: 1}

  belongs_to :brewery, touch: true
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> {uniq}, through: :ratings, source: :user



  def to_s
    "#{self.name}, #{self.brewery.name}"
  end

  def self.top(n)

    sorted_by_rating_in_desc_order = Beer.all.sort_by{|b| -(b.average_rating||0)}
    return sorted_by_rating_in_desc_order.take(n)
  end

end

