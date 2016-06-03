require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  before :each do
    @est1 = Establishment.create!(name:"Teste", address:"Logo Ali", lat:"0", lng:"0", id_places:"321")
    @rating = Rating.create!(woman: 4.0, lgbtqia: 4.0, disability: 4.0, elder: 4.0, obese: 4.0, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04", establishment_id: @est1.id)
  end

  it 'expect to return the average from est' do
    expect(calculate_average_establishment(@est1)).to eq(4)
  end
end
