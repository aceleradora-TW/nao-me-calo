class Rating < ActiveRecord::Base
  belongs_to :users
  belongs_to :establishments
end
