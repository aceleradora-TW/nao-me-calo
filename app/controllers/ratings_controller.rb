class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :edit, :update, :destroy]
  before_action :set_client, only: [:new, :create]
  include ApplicationHelper

  def index
    @ratings = Rating.all
  end

  def show
    redirect_to (@rating.establishment)
  end

  def new
    @rating = Rating.new
    @placeId = params[:placeId]
    @client = GooglePlaces::Client.new(G_PLACE_KEY)

    if params[:placeId] != nil
      begin
        @spot = @client.spot(params[:placeId])
      rescue
        # Se lançar exceção
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
          if @rating.description == ""
            @rating.visible = true
          end
          respond_to do |format|
            if @rating.save
              format.html { redirect_to "/perfil/#{@establishment.id}", notice: 'Avaliação feita com sucesso' }
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
