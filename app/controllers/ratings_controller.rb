class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :edit, :update, :destroy]
  before_action :set_client, only: [:new, :create]
  include ApplicationHelper

  def index
    @ratings = Rating.all
  end

  def report
    @establishments = Establishment.all
    @establishment = @establishments.find_by id: "#{params[:establishment_id]}"
    @ratings = Rating.all
    @report = @ratings.find_by id: "#{params[:report_id]}"

    @client = GooglePlaces::Client.new(G_PLACE_KEY)
    @spot = @client.spot(@establishment.id_places)

    general_average = []
    @establishment.ratings.each do |rating|
      general_average.push(rating.average_rating) unless rating.average_rating.nil?
    end
    @average_rating = general_average.sum/general_average.size #media geral do estabelecimento

    @rating_concept = determine_concept(@average_rating)

    @ratings = @establishment.ratings.reverse_order.limit(5)

    @rate_array = populate_rate_array(@ratings)

  end

  def show
  end

  def new
    @rating = Rating.new
    @placeId = params[:placeId]
    @client = GooglePlaces::Client.new(G_PLACE_KEY)

    if params[:placeId] != nil
      begin
        @spot = @client.spot(params[:placeId])
      rescue
        $establishment = nil
        redirect_to root_path, :flash => {:error => "Erro, por favor, pesquise de novo."}
      end
    else
      redirect_to root_path, :flash => {:error => "Erro, por favor, pesquise de novo."}
    end
  end

  def edit
  end

  def create
    if params[:accepted_terms]

      if Obscenity.profane?(rating_params[:description])
        redirect_to controller: :ratings, action: :new, placeId: params[:placeId]
        flash[:notice] = "* Você usou palavras de baixo calão, por favor, preencha o formulario novamente *"
      else
        @rating = Rating.new(rating_params)
        @establishment = Establishment.search_by_id(params[:placeId]).first

        if(!(@rating.woman.nil? && @rating.lgbtqia.nil? && @rating.race.nil? && @rating.elder.nil? && @rating.obese.nil?))
          if(@establishment.nil?)
            @place = @client.spot(params[:placeId])
            @establishment = Establishment.create!(name: @place.name, address: @place.vicinity+" - "+@place.address_components[5]["short_name"], lat: @place.lat, lng: @place.lng, id_places: @place.place_id)
          end

          @rating.establishment_id = @establishment.id

          respond_to do |format|
            if @rating.save
              format.html { redirect_to "/perfil/#{@establishment.id}", notice: 'Avaliação feita com sucesso' }
            else
              format.html { redirect_to root_path }
            end
          end
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path }
      end
    end
  end

  def destroy
    @rating.destroy
    respond_to do |format|
      format.html { redirect_to ratings_url, notice: 'Rating was successfully destroyed.' }
    end
  end

  private
  def set_rating
    @rating = Rating.find(params[:id])
  end

  def set_client
    @client = GooglePlaces::Client.new(G_PLACE_KEY)
  end

  def rating_params
    params.require(:rating).permit(:woman, :lgbtqia, :race, :disability, :elder, :obese, :name, :cpf, :email, :phone, :rating_date, :establishment_id, :description)
  end
end
