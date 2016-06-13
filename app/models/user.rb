class User < ActiveRecord::Base
  has_many :ratings
  validates :name, presence: true
  validates :cpf, presence: true
end
