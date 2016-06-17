class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :edit, :update, :destroy]
  before_action :set_client, only: [:new, :create]

  def index
    @ratings = Rating.all
  end

  def show
  end

  def new
    @rating = Rating.new
    @place_id = params[:place_id]
    @client = GooglePlaces::Client.new(G_PLACE_KEY)
    if params[:place_id] != nil
      begin
        @spot = @client.spot(params[:place_id])
      rescue => ex
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
    if(params[:accepted_terms])
      @rating = Rating.new(rating_params)
      @establishment = Establishment.search_by_id(params[:place_id]).first

      if(!(@rating.woman.nil? && @rating.lgbtqia.nil? && @rating.race.nil? && @rating.elder.nil? && @rating.obese.nil?))
        if(@establishment.nil?)
          @place = @client.spot(params[:place_id])
          @establishment = Establishment.create!(name: @place.name, address: @place.vicinity+" - "+@place.address_components[5]["short_name"], lat: @place.lat, lng: @place.lng, id_places: @place.place_id)
        end

        @rating.establishment_id = @establishment.id

        respond_to do |format|
          if @rating.save
            format.html { redirect_to "/perfil/#{@establishment.id}", notice: 'Avaliação feita com sucesso' }
          else
            format.html { redirect_to "bing.com.br", notice: "Caiu aqui!" }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to "google.com.br", notice: "Caiu no outro aqui!" }
        end
      end
    else
     respond_to do |format|
       format.html { redirect_to root_path }
     end
   end
  end

  def update
    respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_to @rating, notice: 'Rating was successfully updated.' }
      else
        format.html { render :edit }
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
