class User < ActiveRecord::Base
  include RatingAverage
  validates :username, uniqueness: true,
            length: {in: 3..15}
  validates :password, length: {minimum: 4},
            format: {with: /[a-zA-Z0-9]\p{Lu}/, with: /\d/,
            message: "Must have at least one number and one uppercase letter"}
  has_many :ratings
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships
  has_secure_password

  def favourite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favourite_style
    return nil if ratings.empty?

    return "Lager"

  end


end
