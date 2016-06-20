class WelcomeController < ApplicationController
  before_action :set_client, only: [:index, :search]
  include ApplicationHelper

  def index

     @establishments = Establishment.all
     @establishment_hash={}
     @establishments.each do |estLocal|
       @establishment_hash[estLocal] = calculate_average_establishment(estLocal)
     end

     @pinsForMap = []

     @establishments.each do |establishment|
       @rating = calculate_average_establishment(establishment)
       if(@rating<=1.5)
         @color = "http://maps.google.com/mapfiles/ms/icons/red-dot.png";
       elsif(@rating<=3.5)
         @color = "http://maps.google.com/mapfiles/ms/icons/yellow-dot.png";
       else
         @color = "http://maps.google.com/mapfiles/ms/icons/green-dot.png";
       end

       @pinsForMap.push([establishment.name, establishment.lat.to_f, establishment.lng.to_f, @color, establishment.id])
     end

     @establishment_array = @establishment_hash.sort_by{ |k, v| v }

     @worst_places = []
     @worst_places = setConcept @worst_places,@establishment_array

     @establishment_array = @establishment_array.reverse
     @best_places = []
     @best_places = setConcept @best_places,@establishment_array


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

   def setConcept place,array
     array.take(10).each do |est|
       place.push([est[0],est[1]])
     end
     place.each do |w|
       if w[1] < 2
         w[1] = "Péssimo"
       elsif w[1] < 3
         w[1] = "Ruim"
       elsif w[1] < 4
         w[1] = "Regular"
       elsif w[1] < 5 
         w[1] = "Bom"
       else
         w[1] = "Ótimo"
       end
     end
   end

end
