require 'rails_helper'

RSpec.describe EstablishmentsController, type: :controller do

  describe "#index" do
    before :each do
      @est1 = Establishment.create!(name:"Teste", address:"Logo Ali", lat:"0", lng:"0", id_places:"321")
      @est2 = Establishment.create!(name:"Teste2", address:"Logo Ali2", lat:"0", lng:"0", id_places:"121")
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

  describe '#show' do
    before :each do
      @est1 = Establishment.create!(name:"Teste", address:"Logo Ali", lat:"0", lng:"0", id_places:"321")
      @rating = Rating.create!(woman: 4.0, lgbtqia: 4.0, disability: 4.0, elder: 4.0, obese: 4.0, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04", establishment_id: @est1.id)
      @r2 = Rating.create!(woman: 4.0, lgbtqia: 4.0, disability: 4.0, elder: 4.0, obese: 4.0, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04", establishment_id: @est1.id)
      @r3 = Rating.create!(woman: 4.0, lgbtqia: 4.0, disability: 4.0, elder: 4.0, obese: 4.0, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04", establishment_id: @est1.id)
      @r4 = Rating.create!(woman: 4.0, lgbtqia: 4.0, disability: 4.0, elder: 4.0, obese: 4.0, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04", establishment_id: @est1.id)
      @r5 = Rating.create!(woman: 4.0, lgbtqia: 4.0, disability: 4.0, elder: 4.0, obese: 4.0, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04", establishment_id: @est1.id)
      @r6 = Rating.create!(woman: 4.0, lgbtqia: 4.0, disability: 4.0, elder: 4.0, obese: 4.0, name: "Teste", cpf: "123456", email: "teste", phone: "teste", rating_date:"04/04/04", establishment_id: @est1.id)
    end

    it 'expect @average_rating to be equals 4' do
      get :show, id: @est1.id
      expect(assigns[:average_rating]).to eq(4)
    end

    it 'expect @ratings to be the last 5 ratings' do
      get :show, id: @est1.id
      expect(assigns[:ratings]).to eq([@r6, @r5, @r4, @r3, @r2])
    end
  end

  describe "#create" do
    it "expect to flash notice when the establishment is created" do
      post :create, {establishment:
      {
        name: "teste",
        address: "logo ali",
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
      @est1 = Establishment.create!(name:"Teste", address:"Logo Ali", lat:"0", lng:"0", id_places:"321")
    end

    it "expect to flash notice when the establishment is updated " do
      put :update,{
        id: @est1.id, establishment:
        {
          name: "testedo teste",
          address: "logo ali",
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
      @est1 = Establishment.create!(name:"Teste", address:"Logo Ali", lat:"0", lng:"0", id_places:"321")
    end

    it 'flash notice when establishment is destroyed' do
      delete :destroy, id: @est1.id
      expect(flash[:notice]).to eq("Establishment was successfully destroyed.")
    end
  end
end
