require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "#index" do
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

    # it 'expect establishment has to have key establishment and average' do
    #   get :index
    #   expect(assigns[:establishment_hash]).to eq({@est1 => 1.0, @est2 => 2.0, @est3 => 3.0, @est4 => 4.0, @est5 => 5.0})
    # end

    it 'expect pins ForMap to have two establishment correctly' do
      get :index
      expect(assigns[:pinsForMap]).to eq([
        [@est1.name, @est1.lat.to_f, @est1.lng.to_f, "http://www.googlemapsmarkers.com/v1/O/E03535/", @est1.id, "Péssimo", "concept-dangerous"],
        [@est2.name, @est2.lat.to_f, @est2.lng.to_f, "http://www.googlemapsmarkers.com/v1/O/FF6633/", @est2.id, "Ruim", "concept-bad"],
        [@est3.name, @est3.lat.to_f, @est3.lng.to_f, "http://www.googlemapsmarkers.com/v1/O/FFBD14/", @est3.id, "Regular", "concept-regular"],
        [@est4.name, @est4.lat.to_f, @est4.lng.to_f, "http://www.googlemapsmarkers.com/v1/O/99CC00/", @est4.id, "Bom", "concept-good"],
        [@est5.name, @est5.lat.to_f, @est5.lng.to_f, "http://www.googlemapsmarkers.com/v1/O/329853/", @est5.id, "Ótimo", "concept-excellent"]
        ])
    end

    it 'shows on the list only establishments with at least 3 ratings' do
      Rating.create!(woman: 1.0,race: 1.0, lgbtqia: 1.0, disability: 1.0, elder: 1.0, obese: 1.0, name: "Teste", cpf: "02306418063", email: "teste", phone: "teste", rating_date:"04/04/04", establishment_id: @est1.id)
      Rating.create!(woman: 1.0,race: 1.0, lgbtqia: 1.0, disability: 1.0, elder: 1.0, obese: 1.0, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04", establishment_id: @est1.id)
      get :index
      expect(assigns[:establishment_hash]).to eq({@est1 => 1.0})
    end
  end

  describe '#search' do
    before :each do
      @est1 = Establishment.create!(name:"Teste", address:"Logo Ali", lat:"0", lng:"0", id_places:"321")
    end

    it 'expect to redirect to establishment when passing a existing ID' do
      post :search, placeId2: @est1.id_places
      expect(response).to redirect_to(@est1)
    end

    it 'expect to flash error when establishment does not exist' do
      post :search, placeId2: "ChIJtRXsKP93GZURV_D3fEejaXc"
      expect(flash[:error]).to eq('Lugar ainda não foi avaliado. Clique nessa mensagem para avalia-lo.')
    end
  end
end
