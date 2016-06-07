require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe '#average_rating' do
    before :each do
      @rating = Rating.create!(woman: 4.0, lgbtqia: 4.0, disability: 4.0, elder: 4.0, obese: 4.0, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04",establishment_id:1)
      @rating2 = Rating.create!(woman: nil, lgbtqia: nil, disability: nil, elder: nil, obese: nil, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04",establishment_id:1)
    end

    it 'calculate average rating from this rating' do
      expect(@rating.average_rating).to eq(4)
    end

    it 'expect to return nil when all ratings are empty' do
      expect(@rating2.average_rating).to be(nil)
    end
  end
end
