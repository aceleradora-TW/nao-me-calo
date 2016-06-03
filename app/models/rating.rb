class Rating < ActiveRecord::Base
has_one :establishment

  def average_rating
    
    all_ratings = [self.woman, self.lgbtqia, self.race, self.disability, self.elder, self.obese]
    all_ratings.delete_if {|rating| rating == nil}

    if(all_ratings.empty?)
      return nil
    end

    return (all_ratings.sum/all_ratings.length).round(1) #media parcial
  end
end
