class EstablishmentsController < ApplicationController
  before_action :set_establishment, only: [:show, :edit, :update, :destroy]
  before_action :set_client, only: [:show]

  # GET /establishments
  # GET /establishments.json
  def index
    @establishments = Establishment.all
  end

  # GET /establishments/1
  # GET /establishments/1.json
  def show
    @client = GooglePlaces::Client.new(G_PLACE_KEY)
    @spot = @client.spot(@establishment.id_places)
    general_average = []
    @establishment.ratings.each do |rating|
      general_average.push(rating.average_rating) unless rating.average_rating.nil?
    end
    @average_rating = general_average.sum/general_average.size #media geral do estabelecimento
    @rating_concept

    case @average_rating
    when 1 ... 1.8
      @rating_concept = "Péssimo"
    when 1.8 ... 2.6
      @rating_concept = "Ruim"
    when 2.6 ... 3.4
      @rating_concept = "Regular"
    when 3.4 ... 4.2
      @rating_concept = "Bom"
    else
      @rating_concept = "Ótimo"
    end

    @ratings = @establishment.ratings.reverse_order.limit(5)
    @rate_array = []
    @ratings.each do |rating|
      if rating.average_rating < 1.8
        @rate_array.push([rating,"Péssimo"])
      elsif rating.average_rating < 2.6
        @rate_array.push([rating,"Ruim"])
      elsif rating.average_rating < 3.4
        @rate_array.push([rating,"Regular"])
      elsif rating.average_rating < 4.2
        @rate_array.push([rating,"Bom"])
      else
        @rate_array.push([rating,"Ótimo"])
      end
    end
  end

  # GET /establishments/new
  def new
    @establishment = Establishment.new
  end

  # GET /establishments/1/edit
  def edit
  end

  # POST /establishments
  # POST /establishments.json
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

  # PATCH/PUT /establishments/1
  # PATCH/PUT /establishments/1.json
  def update
    respond_to do |format|
      if @establishment.update(establishment_params)
        format.html { redirect_to @establishment, notice: 'Establishment was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /establishments/1
  # DELETE /establishments/1.json
  def destroy
    @establishment.destroy
    respond_to do |format|
      format.html { redirect_to establishments_url, notice: 'Establishment was successfully destroyed.' }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_establishment
    @establishment = Establishment.find(params[:id])
  end

  def set_client
    @client = GooglePlaces::Client.new(G_PLACE_KEY)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def establishment_params
    params.require(:establishment).permit(:name, :address, :average_rating, :lat, :lng, :id_places)
  end
end
