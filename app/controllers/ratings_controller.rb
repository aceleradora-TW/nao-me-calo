class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :edit, :update, :destroy]
  before_action :set_client, only: [:new, :create]
  include ApplicationHelper
  require 'concept.rb'

  def index
    @ratings = Rating.all
  end

  def show
    @client = GooglePlaces::Client.new(G_PLACE_KEY)
    @spot = @client.spot(@rating.establishment.id_places)
    @rating_description = Concept.determine_concept(@rating.average_rating)
    @concept = Concept.generate_concept(@rating.establishment)
    @date_description = @rating.rating_date.strftime("%d/%m/%Y")
  end

  def new
    @rating = Rating.new
    @placeId = params[:placeId]
    @client = GooglePlaces::Client.new(G_PLACE_KEY)

    if params[:placeId] != nil
      begin
        @spot = @client.spot(params[:placeId])
      rescue
        puts "Erro com o google places, favor verificar."
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

        if(!(@rating.woman.nil? && @rating.lgbtqia.nil? && @rating.race.nil? && @rating.disability.nil? && @rating.elder.nil? && @rating.obese.nil?))
          if(@establishment.nil?)
            @place = @client.spot(params[:placeId])
            @establishment = Establishment.create!(name: @place.name, address: @place.formatted_address, lat: @place.lat, lng: @place.lng, id_places: @place.place_id)
          end
          if @rating.description == ""
            @rating.visible = true
            @rating.moderated = true
          end

          @rating.establishment_id = @establishment.id
          respond_to do |format|
            if @rating.save && !(@rating.description=="")
              format.html { redirect_to "/perfil/#{@establishment.id}", notice: 'Avaliação feita com sucesso! Sua avaliação ira passar pela moderação.' }
            elsif @rating.save
              format.html { redirect_to "/perfil/#{@establishment.id}", notice: 'Avaliação feita com sucesso!' }
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

  def visible
    @rating = Rating.find(params[:rating_id])

    if (@rating.visible == false)
      @rating.visible = true
      @rating.moderated = true
    else
      @rating.visible = false
    end

    respond_to do |format|
      if @rating.save
        format.html { redirect_to admin_root_path, notice: "Success!" }
      else
        format.html { redirect_to admin_root_path }
      end
    end
  end

  def moderated
    @rating = Rating.find(params[:rating_id])

    respond_to do |format|
      if(@rating.moderated == false)
        @rating.moderated = true
      else
        format.html { redirect_to admin_root_path, :flash => {:error => "A avaliação já foi moderada anteriormente."} }
      end

      if @rating.save
        format.html { redirect_to admin_root_path, notice: "Success!" }
      else
        format.html { redirect_to admin_root_path }
      end
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
