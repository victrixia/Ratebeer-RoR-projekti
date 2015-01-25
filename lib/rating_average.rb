module RatingAverage
  def average_rating
    a = Array.new

    self.ratings.each do |rating|
      a << rating.score
    end

    a.inject { |sum, n| sum + n }/a.count
  end
end
