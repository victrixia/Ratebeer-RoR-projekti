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

  def favourite(category)
    return nil if ratings.empty?

    category_ratings = rated(category).inject([]) do |set, item|
      set << {
          item: item,
          rating: rating_of(category, item) }
    end

    category_ratings.sort_by { |item| item[:rating] }.last[:item]
  end

  def favourite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end


  def favourite_brewery
    favourite(:brewery)
  end

  def favourite_style
    favourite(:style)
  end

  def self.users_with_most_ratings(n)
    users_with_most_ratings = User.all.sort_by{|u| -(u.ratings.count||0)}
    return users_with_most_ratings.take (n)

  end

  private

  def rated(category)
    ratings.map{|r| r.beer.send(category)}.uniq
  end

  def rated_styles

    rated(:style)
  end

  # def rating_of_style(object)
  #   ratings_of_style = ratings.select { |r| r.beer.style==style }
  #   ratings_of_style.inject(0.0) { |sum, r| sum+r.score }/ratings_of_style.count
  # end

  def rated_breweries

    rated(:brewery)
  end

  def rating_of(category, item)
    ratings_of_item = ratings.select do |r|
      r.beer.send(category) == item
    end
    ratings_of_item.map(&:score).sum / ratings_of_item.count
  end



  # def rating_of(x, object)
  #
  #   x = :brewery
  #
  #   ratings_of_brewery = ratings.select do |r|
  #     r.beer.send(x) == object
  #   end
  #   ratings_of_brewery.map(&:score).sum/ratings_of_brewery.count
  # end


end
