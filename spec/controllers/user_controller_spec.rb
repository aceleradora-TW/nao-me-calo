require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#index' do
    before :each do
      @user1 = User.create!(name:"Ruas", email:"ruas23@lol.com", cpf:"25898989898", telephone:"65565656")
      @user2 = User.create!(name:"Lindo", email:"ruas42131@lol.com", cpf:"258989898921312312", telephone:"213123126")
    end

    it 'expect @users to be all users' do
      get :index
      expect(assigns[:users]).to eq([@user1, @user2])
    end
  end

  describe '#new' do
    it 'expect @user to be a new User' do
      get :new
      expect(assigns[:user]).to be_a(User)
    end
  end

  describe '#create' do
    it 'expect flash notice when user is created' do
      post :create, {
        user:
        {
          name:"Ruas",
          email:"lindo@ruas.com",
          cpf:"2232323",
          telephone:"123132131"
        }
      }
      expect(flash[:notice]).to eq("User was successfully created.")
    end

    it 'render new when something goes wrong' do
      post :create, {
        user:
        {
          email:"lindo@ruas.com",
          cpf:"2232323",
          telephone:"123132131"
        }
      }
      expect(response).to render_template(:new)
    end
  end

  describe '#update' do
    before :each do
      @user1 = User.create!(name:"Ruas", email:"ruas23@lol.com", cpf:"25898989898", telephone:"65565656")
    end

    it 'expect flash notice when user is successfully updated' do
      put :update, {id: @user1.id, user:{
          name: "Ruas",
          email:"lindo@ruas.com",
          cpf:"2232323",
          telephone:"123132131"
        }
      }
      expect(flash[:notice]).to eq("User was successfully updated.")
    end

    it 'expect to render edit when something goes wrong' do
      put :update, {id: @user1.id, user:{
          name: nil,
          email:"lindo@ruas.com",
          cpf:"2232323",
          telephone:"123132131"
        }
      }
      expect(response).to render_template(:edit)
    end
  end

  describe '#destroy' do
    before :each do
      @user1 = User.create!(name:"Ruas", email:"ruas23@lol.com", cpf:"25898989898", telephone:"65565656")
    end

    it 'expect to flash notice when User is successfully destroyed' do
      delete :destroy, id: @user1.id
      expect(flash[:notice]).to eq("User was successfully destroyed.")
    end
  end
end
