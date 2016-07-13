class WelcomeController < ApplicationController
  before_action :set_client, only: [:index, :search]
  include ApplicationHelper
  include WelcomeHelper
  include RatingsHelper
  require 'ranking.rb'

  def index
    @establishments = Establishment.all
    @establishment_hash = {}
    @pinsForMap = []
    @establishments.each do |establishment|
      if establishment.has_more_than_2_ratings?
        @establishment_hash[establishment] = establishment.calculate_average
        @color_and_rating = get_color_and_pin_concept(@establishment_hash[establishment])
        @pinsForMap << [establishment.name, establishment.lat.to_f, establishment.lng.to_f, @color_and_rating[0], establishment.id, @color_and_rating[1], set_average_style(@color_and_rating[1]), establishment.has_more_than_2_ratings?]
      end
    end
    @share_text = "Veja o ranking dos estabelecimentos mais e menos amigaveis para oprimidos"

    @establishment_array = Ranking.generate_array_ranking(@establishments)

    @worst_places = []
    @worst_places = set_concept(@worst_places, @establishment_array)

    @establishment_array = @establishment_array.reverse
    @best_places = []
    @best_places = set_concept(@best_places, @establishment_array)

    time = Time.now
    if time.hour > 1
      clean_CPF_from_db
    end
  end

  def search
    @establishment = Establishment.search_by_id(params[:placeId2]).first
    if(@establishment.nil?)
      $establishment = @client.spot(params[:placeId2])
      redirect_to root_path, :flash => { :error => "Lugar ainda não foi avaliado. Clique nessa mensagem para avalia-lo." }
    else
      redirect_to @establishment
    end
  end

  def help
  end

  def terms
  end

  def get_color_and_pin_concept(rating)
    case rating
    when  1 .. 1.8
      color = "http://www.googlemapsmarkers.com/v1/O/E03535/"
      pin_concept = "Péssimo"
    when 1.9 .. 2.6
      color = "http://www.googlemapsmarkers.com/v1/O/FF6633/"
      pin_concept = "Ruim"
    when  2.7 .. 3.4
      color = "http://www.googlemapsmarkers.com/v1/O/FFBD14/"
      pin_concept = "Regular"
    when 3.5 .. 4.2
      color = "http://www.googlemapsmarkers.com/v1/O/99CC00/"
      pin_concept = "Bom"
    else
      color = "http://www.googlemapsmarkers.com/v1/O/329853/"
      pin_concept = "Ótimo"
    end

    return [color, pin_concept]
  end

  private

  def set_client
    @client = GooglePlaces::Client.new(G_PLACE_KEY)
  end


end
