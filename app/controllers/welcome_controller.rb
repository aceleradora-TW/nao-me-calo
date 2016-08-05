include ApplicationHelper
include WelcomeHelper
include RatingsHelper
require 'ranking.rb'
require 'concept.rb'

class WelcomeController < ApplicationController
  before_action :set_client, only: [:index, :search]
  before_action :clean_CPF_from_db_six_months, only: [:index]

  def index
    $establishments = Establishment.all
    $establishment_hash = {}
    @pinsForMap = []
    $establishments.each do |establishment|

      if establishment.has_more_than_2_ratings?
        $establishment_hash[establishment] = establishment.calculate_average
        @color_and_rating = get_color_and_pin_concept($establishment_hash[establishment])
        @pinsForMap << [establishment.name, establishment.lat.to_f, establishment.lng.to_f, @color_and_rating[0], establishment.id, @color_and_rating[1], set_average_style(@color_and_rating[1]), establishment.has_more_than_2_ratings?]
      end
    end
    @share_text = "Veja o ranking dos estabelecimentos mais e menos amigaveis para oprimidos"

    @worst_places = generate_ranking.take(5)
    @best_places = generate_ranking.reverse.take(5)
  end

  def search
    $establishment = Establishment.search_by_id(params[:placeId2]).first
    if($establishment.nil?)
      $establishment = @client.spot(params[:placeId2])
      redirect_to root_path, :flash => { :error => "Lugar ainda não foi avaliado. Clique nessa mensagem para avalia-lo." }
    else
      redirect_to $establishment
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

  def clean_CPF_from_db_six_months
    clean_CPF_from_db
  end

  def get_color_and_pin_concept(rating)
    pin_concept = Concept.determine_concept(rating)
    case rating
    when  1 ... 1.8
      color = "http://www.googlemapsmarkers.com/v1/O/E03535/"
    when 1.8 ... 2.6
      color = "http://www.googlemapsmarkers.com/v1/O/FF6633/"
    when  2.6 ... 3.4
      color = "http://www.googlemapsmarkers.com/v1/O/FFBD14/"
    when 3.4 ... 4.2
      color = "http://www.googlemapsmarkers.com/v1/O/99CC00/"
    else
      color = "http://www.googlemapsmarkers.com/v1/O/329853/"
    end

    return [color, pin_concept]
  end


end
