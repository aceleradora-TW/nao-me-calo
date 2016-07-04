require 'rails_helper'

RSpec.describe ContactUsController, type: :controller do


  describe "#send_mail" do


    it "expect to flash notice when the rating is create " do

      post :send_mail
      {
        message: "teste",
        email: "teste@teste.com",
        subject: "teste",
        name: "teste",
      }

      expect(flash[:notice]).to eq('Mensagem enviada com sucesso!')
    end

  

  end

end
