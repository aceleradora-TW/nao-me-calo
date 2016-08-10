include ApplicationHelper
include WelcomeHelper
require 'concept.rb'

class EstablishmentsController < ApplicationController
  before_action :set_establishment, only: [:show, :edit, :update, :destroy, :search]
  before_action :set_client, only: [:show]

  def index
    @establishments = Establishment.all
    redirect_to root_path
  end

  def show
    @client = GooglePlaces::Client.new(G_PLACE_KEY)
    @spot = @client.spot(@establishment.id_places)
    @rating_concept = Concept.generate_concept(@establishment)

    @ratings = []

    @establishment.ratings.each do |rating|
      @ratings << rating
    end
    @ratings.reverse!

    @ratings_array = @establishment.populate_rate_array(@ratings)


  end

  def ranking
    if params[:search] != nil
      @establishments = Establishment.search_by_city(params[:search])
    elsif
      @establishments = Establishment.all
    end
    @share_text = "Confira o ranking dos estabelecimentos mais ou menos amigáveis para grupos oprimidos"

    @worst_places = generate_ranking
    @best_places = @worst_places.reverse

    respond_to do |format|
      if request.xhr?
        format.js
      else
        format.html
      end
    end
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


  def set_establishment
    @establishment = Establishment.find(params[:id])
  end

  def set_client
    @client = GooglePlaces::Client.new(G_PLACE_KEY)
  end

  def establishment_params
    params.require(:establishment).permit(:name, :address, :average_rating, :lat, :lng, :id_places, :city, :city_input_ranking)
  end
end
