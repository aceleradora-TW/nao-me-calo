class WelcomeController < ApplicationController
  before_action :set_client, only: [:index, :search]
  include ApplicationHelper

  def index
    # @establishments = Establishment.include(:ratings)
    # @est{}
    # @establishments.each do |e| {
    #   @est[e.name.to_sym] = calculate_average_establishment(e)
    # }
    # @est = @establishments.to_a
    #@est.sort! { |a,b| calculate_average_establishment(a) <=> calculate_average_establishment(b)}
    #  @establishments = Establishment.select('establishments.* , MAX(ratings.rating_date) as rd').joins(:ratings).order('rd desc').group('establishments.id').first(5)
     @establishments = Establishment.all
     @establishment_hash={}
     @establishments.each do |estLocal|
       @establishment_hash[estLocal] = calculate_average_establishment(estLocal)
     end
     @establishment_array = @establishment_hash.sort_by{ |k, v| v }
     @worst_places = @establishment_array[0..4]
     @establishment_array = @establishment_array.reverse
     @best_places = @establishment_array[0..4]
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
