class Movie < ActiveRecord::Base

  def self.ratings
    ratings = self.all(:select => 'distinct(rating)').map(&:rating)
  
  end
end
