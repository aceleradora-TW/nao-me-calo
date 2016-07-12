class EstablishmentsController < ApplicationController
  before_action :set_establishment, only: [:show, :edit, :update, :destroy]
  before_action :set_client, only: [:show]
  include ApplicationHelper
  include WelcomeHelper

  def index
    @establishments = Establishment.all
  end

  def show
    @client = GooglePlaces::Client.new(G_PLACE_KEY)
    @spot = @client.spot(@establishment.id_places)
    generate_concept

    @ratings = @establishment.ratings.reverse_order

    @rate_array = populate_rate_array(@ratings)
  end

  def ranking
  @establishments = Establishment.all
  @establishment_hash = {}
  @establishments.each do |establishment|
    if establishment.has_more_than_2_ratings?
      @establishment_hash[establishment] = calculate_average_establishment(establishment)
    end
  end
  @share_text = "Veja o ranking dos estabelecimentos mais e menos amigaveis para oprimidos"

  @establishments.each do |establishment|
    if establishment.has_more_than_2_ratings?
      @rating_establishment = calculate_average_establishment establishment
      @rating_establishment.round(1)
    end
  end

  @establishment_array = @establishment_hash.sort_by{ |_key, value| value }

  @worst_places = []
  @worst_places = set_concept(@worst_places, @establishment_array)

  @establishment_array = @establishment_array.reverse
  @best_places = []
  @best_places = set_concept(@best_places, @establishment_array)
end


  def new
    @establishment = Establishment.new
  end

  def update
    @establishment = Establishment.find(params[:id])
  end

  def create
    @establishment = Establishment.new(establishment_params)

    respond_to do |format|
      if @establishment.save
        format.html { redirect_to @establishment, notice: 'Establishment was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    @establishment.destroy
    respond_to do |format|
      format.html { redirect_to establishments_url, notice: 'Establishment was successfully destroyed.' }
    end
  end

  private

  def generate_concept
    if @establishment.has_more_than_2_ratings?
      general_average = []
      @establishment.ratings.each do |rating|
        general_average.push(rating.average_rating) unless rating.average_rating.nil?
      end

      @average_rating = general_average.sum/general_average.size #media geral do estabelecimento

      @rating_concept = determine_concept(@average_rating)
      return @rating_concept
    else
      @rating_concept = nil
    end
  end



  def set_establishment
    @establishment = Establishment.find(params[:id])
  end

  def set_client
    @client = GooglePlaces::Client.new(G_PLACE_KEY)
  end

  def establishment_params
    params.require(:establishment).permit(:name, :address, :average_rating, :lat, :lng, :id_places)
  end
end
