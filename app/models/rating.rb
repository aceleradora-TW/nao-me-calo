class Rating < ActiveRecord::Base
has_one :establishment
validates :rating_date, presence: true
validates :cpf, presence: true
validates :establishment_id, presence: true

  def average_rating

    all_ratings = [self.woman, self.lgbtqia, self.race, self.disability, self.elder, self.obese]
    all_ratings.delete_if {|rating| rating == nil}

    if(all_ratings.empty?)
      return nil
    end

    return (all_ratings.sum/all_ratings.length).round(1) #media parcial
  end
end
