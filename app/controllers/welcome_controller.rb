class WelcomeController < ApplicationController
  def index
    @establishments = Establishment.create(
    [{
        name: "Beco",
        address: "Exemplo"
      },
      {
        name: "Beco",
        address: "Exemplo"
      },
      {
        name: "Beco",
        address: "Exemplo"
      },
      {
        name: "Beco",
        address: "Exemplo"
      },
      {
        name: "Beco",
        address: "Exemplo"
      }]
    )
  end

  def search
    
  end
end
