require 'rails_helper'

RSpec.describe EstablishmentsController, type: :controller do

  describe "#index" do
    before :each do
      @est1 = Establishment.create!(name:"Teste", address:"Logo Ali", average_rating:5.0, lat:"0", lng:"0", id_places:"321")
      @est2 = Establishment.create!(name:"Teste2", address:"Logo Ali2", average_rating:6.0, lat:"0", lng:"0", id_places:"121")
    end

    it "expect @establishments to be all Establishments" do
      get :index
      expect(assigns[:establishments]).to eq([@est1, @est2])
    end
  end


  describe "#new" do
    it "expect @establishment to be a new Establishments" do
      get :new
      expect(assigns[:establishment]).to be_a(Establishment)
    end
  end

  describe "#create" do
    it "expect to flash notice when the establishment is created" do
      post :create, {establishment:
      {
        name: "teste",
        address: "logo ali",
        average_rating: 5.0,
        lat: "0",
        lng: "0",
        id_places: "321"
        }
      }
      expect(flash[:notice]).to eq("Establishment was successfully created.")
    end

    it "expect render new when establishment is not created" do
      post :create, {establishment:
      {
        name: "Teste",
        average_rating: "5.0",
        lat: "0",
        lng: "0",
        id_places: "321"
        }
      }
      expect(response).to render_template(:new)
    end
  end

  describe "#update" do
    before :each do
      @est1 = Establishment.create!(name:"Teste", address:"Logo Ali", average_rating:5.0, lat:"0", lng:"0", id_places:"321")
    end

    it "expect to flash notice when the establishment is updated " do
      put :update,{
        id: @est1.id, establishment:
        {
          name: "testedo teste",
          address: "logo ali",
          average_rating: 5.0,
          lat: "0",
          lng: "0",
          id_places: "321"
        }
      }
      expect(flash[:notice]).to eq("Establishment was successfully updated.")
    end

    it "expect to flash notice when the establishment is updated " do
      put :update,{
        id: @est1.id, establishment:
        {
          name: "testedo teste",
          address: "logo ali",
          average_rating: 5.0,
          lat: "0",
          lng: "0",
          id_places: "321"
        }
      }
      expect(flash[:notice]).to eq("Establishment was successfully updated.")
    end

    it "expect to render edit when something goes wrong with Update " do
      put :update,{
        id: @est1.id, establishment:
        {
          name: "",
          address: "logo ali",
          average_rating: 5.0,
          lat: "0",
          lng: "0",
          id_places: "321"
        }
      }
      expect(response).to render_template(:edit)
    end
  end

  describe '#destroy' do
    before :each do
      @est1 = Establishment.create!(name:"Teste", address:"Logo Ali", average_rating:5.0, lat:"0", lng:"0", id_places:"321")
    end

    it 'flash notice when establishment is destroyed' do
      delete :destroy, id: @est1.id
      expect(flash[:notice]).to eq("Establishment was successfully destroyed.")
    end
  end
end
