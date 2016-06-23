class WelcomeController < ApplicationController
  before_action :set_client, only: [:index, :search]
  include ApplicationHelper

  def index

    @establishments = Establishment.all
    @establishment_hash = {}
    @establishments.each do |establishment|
      @establishment_hash[establishment] = calculate_average_establishment(establishment)
    end

    @pinsForMap = []

    @establishments.each do |establishment|
      @rating = calculate_average_establishment(establishment)
      if(@rating <= 1.5)
        @color = "http://maps.google.com/mapfiles/ms/icons/red-dot.png";
      elsif(@rating <= 3.5)
        @color = "http://maps.google.com/mapfiles/ms/icons/yellow-dot.png";
      else
        @color = "http://maps.google.com/mapfiles/ms/icons/green-dot.png";
      end

      @pinsForMap << [establishment.name, establishment.lat.to_f, establishment.lng.to_f, @color, establishment.id]
    end

    @establishment_array = @establishment_hash.sort_by{ |key, value| value }

    @worst_places = []
    @worst_places = set_concept(@worst_places, @establishment_array)

    @establishment_array = @establishment_array.reverse
    @best_places = []
    @best_places = set_concept(@best_places, @establishment_array)


  end

  def search
    @establishment = Establishment.search_by_id(params[:place_id_2]).first
    if(@establishment.nil?)
      $establishment = @client.spot(params[:place_id_2])
      redirect_to root_path, :flash => { :error => "Lugar ainda não foi avaliado. Clique nessa mensagem para avalia-lo." }
    else
      redirect_to @establishment
    end
  end

  def help
  end

  def terms
  end

  private

  def set_client
    @client = GooglePlaces::Client.new(G_PLACE_KEY)
  end

  def set_concept (places, array)
    array.take(10).each do |establishment|
      places << [establishment[0], establishment[1]]
    end
    places.each do |place|
      if place[1] < 2
        place[1] = "Péssimo"
      elsif place[1] < 3
        place[1] = "Ruim"
      elsif place[1] < 4
        place[1] = "Regular"
      elsif place[1] < 5
        place[1] = "Bom"
      else
        place[1] = "Ótimo"
      end
    end
  end

end
