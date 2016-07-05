require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  before :each do
    @est1 = Establishment.create!(name:"Teste", address:"Logo Ali", lat:"0", lng:"0", id_places:"321")
    @est2 = Establishment.create!(name:"Teste2", address:"Logo Ali2", lat:"0", lng:"0", id_places:"121")
    @est3 = Establishment.create!(name:"Teste3", address:"Logo Ali3", lat:"0", lng:"0", id_places:"1212")
    @est4 = Establishment.create!(name:"Teste4", address:"Logo Ali4", lat:"0", lng:"0", id_places:"1213")
    @est5 = Establishment.create!(name:"Teste5", address:"Logo Ali5", lat:"0", lng:"0", id_places:"1212")
    @r1 = Rating.create!(woman: 1.0,race: 1.0, lgbtqia: 1.0, disability: 1.0, elder: 1.0, obese: 1.0, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04", establishment_id: @est1.id)
    @r2 = Rating.create!(woman: 2.0,race: 2.0, lgbtqia: 2.0, disability: 2.0, elder: 2.0, obese: 2.0, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04", establishment_id: @est2.id)
    @r3 = Rating.create!(woman: 3.0,race: 3.0, lgbtqia: 3.0, disability: 3.0, elder: 3.0, obese: 3.0, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04", establishment_id: @est3.id)
    @r4 = Rating.create!(woman: 4.0,race: 4.0, lgbtqia: 4.0, disability: 4.0, elder: 4.0, obese: 4.0, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04", establishment_id: @est4.id)
    @r5 = Rating.create!(woman: 5.0,race: 5.0, lgbtqia: 5.0, disability: 5.0, elder: 5.0, obese: 5.0, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04", establishment_id: @est5.id)
  end

  it 'expect to return the average from establishments' do
    expect(calculate_average_establishment(@est1)).to eq(1)
    expect(calculate_average_establishment(@est2)).to eq(2)
    expect(calculate_average_establishment(@est3)).to eq(3)
    expect(calculate_average_establishment(@est4)).to eq(4)
    expect(calculate_average_establishment(@est5)).to eq(5)
  end
end
