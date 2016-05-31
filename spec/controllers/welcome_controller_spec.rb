require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "#index" do
    before :each do
      @est1 = Establishment.create!(name:"Teste", address:"Logo Ali", average_rating:5.0, lat:"0", lng:"0", id_places:"321")
      @est2 = Establishment.create!(name:"Teste2", address:"Logo Ali2", average_rating:6.0, lat:"0", lng:"0", id_places:"121")
    end

    it 'expect to @establishments to be all establishments on DB' do
      get :index
      expect(assigns[:establishments]).to eq([@est1, @est2])
    end
  end

  describe '#search' do
    before :each do
      @est1 = Establishment.create!(name:"Teste", address:"Logo Ali", average_rating:5.0, lat:"0", lng:"0", id_places:"321")
    end

    it 'expect to redirect to establishment when passing a existing ID' do
      post :search, place_id_2: @est1.id_places
      expect(response).to redirect_to(@est1)
    end

    it 'expect to flash error when establishment does not exist' do
      post :search, place_id_2: nil
      expect(flash[:error]).to eq('Lugar ainda não foi avaliado. Por favor, avalie abaixo.')
    end
  end
end
