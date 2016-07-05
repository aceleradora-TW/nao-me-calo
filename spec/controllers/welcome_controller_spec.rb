require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "#index" do
    before :each do
      @est1 = Establishment.create!(name:"Teste", address:"Logo Ali", lat:"0", lng:"0", id_places:"321")
      @est2 = Establishment.create!(name:"Teste2", address:"Logo Ali2", lat:"0", lng:"0", id_places:"121")
      @r1 = Rating.create!(woman: 4.0,race: 4.0, lgbtqia: 4.0, disability: 4.0, elder: 4.0, obese: 4.0, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04", establishment_id: @est1.id)
      @r2 = Rating.create!(woman: 4.0,race: 4.0, lgbtqia: 4.0, disability: 4.0, elder: 4.0, obese: 4.0, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04", establishment_id: @est2.id)
    end

    it 'expect establishment has to have key establishment and average' do
      get :index
      expect(assigns[:establishment_hash]).to eq({@est1 => 4.0, @est2 => 4})
    end

    it 'expect pins ForMap to have two establishment correctly' do
      get :index
      expect(assigns[:pinsForMap]).to eq([["Teste", 0.0, 0.0, "http://www.googlemapsmarkers.com/v1/O/99CC00/", @est1.id, "Bom", "concept-good"], ["Teste2", 0.0, 0.0, "http://www.googlemapsmarkers.com/v1/O/99CC00/", @est2.id, "Bom", "concept-good"]])
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
