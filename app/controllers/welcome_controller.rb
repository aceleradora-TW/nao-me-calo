class WelcomeController < ApplicationController
  before_action :set_client, only: [:index, :search]
  include ApplicationHelper
  include WelcomeHelper

  def index

    @establishments = Establishment.all
    @establishment_hash = {}
    @establishments.each do |establishment|
      @establishment_hash[establishment] = calculate_average_establishment(establishment)
    end

    @pinsForMap = []

    @establishments.each do |establishment|
      @rating = calculate_average_establishment establishment
      @rating.round(1)
      case @rating
      when  1 .. 1.8
        @color = "http://www.googlemapsmarkers.com/v1/O/E03535/"
        @pin_concept = "Péssimo"
      when 1.9 .. 2.6
        @color = "http://www.googlemapsmarkers.com/v1/O/FF6633/"
        @pin_concept = "Ruim"
      when  2.7 .. 3.4
        @color = "http://www.googlemapsmarkers.com/v1/O/FFBD14/"
        @pin_concept = "Regular"
      when 3.5 .. 4.2
        @color = "http://www.googlemapsmarkers.com/v1/O/99CC00/"
        @pin_concept = "Bom"
      else
        @color = "http://www.googlemapsmarkers.com/v1/O/329853/"
        @pin_concept = "Ótimo"
      end


      @pinsForMap << [establishment.name, establishment.lat.to_f, establishment.lng.to_f, @color, establishment.id, @pin_concept, set_average_style(@pin_concept)]
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


end
