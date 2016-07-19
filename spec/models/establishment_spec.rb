require 'rails_helper'

RSpec.describe Establishment, type: :model do
  before :each do
    @est1 = Establishment.create!(name:"Teste", address:"Logo Ali", lat:"0", lng:"0", id_places:"321")
    @r1 = Rating.create!(woman: 1.0,race: 1.0, lgbtqia: 1.0, disability: 1.0, elder: 1.0, obese: 1.0, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04", establishment_id: @est1.id, moderated: true)
    @ratings1 = [@r1, @r1]
    @r3 = Rating.create!(woman: 3.0,race: 3.0, lgbtqia: 3.0, disability: 3.0, elder: 3.0, obese: 3.0, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04", establishment_id: @est1.id, moderated: true)
    @ratings3 = [@r3, @r3]
    @r5 = Rating.create!(woman: 5.0,race: 5.0, lgbtqia: 5.0, disability: 5.0, elder: 5.0, obese: 5.0, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04", establishment_id: @est1.id, moderated: true)
    @ratings5 = [@r5, @r5]
  end

  it 'expect to populate rate result with ratings and pessimo' do
    expect(@est1.populate_rate_array(@ratings1)).to eq([[@r1, "Péssimo"], [@r1, "Péssimo"]])
  end

  it 'expect to populate rate result with rating and regular' do
    expect(@est1.populate_rate_array(@ratings3)).to eq([[@r3, "Regular"], [@r3, "Regular"]])
  end

  it 'expect to populate with rating and otimo' do
    expect(@est1.populate_rate_array(@ratings5)).to eq([[@r5, "Ótimo"], [@r5, "Ótimo"]])
  end
end
