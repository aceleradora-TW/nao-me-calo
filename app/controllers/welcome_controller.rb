class WelcomeController < ApplicationController
  helper_method :calculate_average_establishment
  
  def index
    @establishments = Establishment.includes(:ratings).order("ratings.rating_date desc").limit(5)

  end

  def search
    @establishment = Establishment.search_by_id(params[:place_id_2]).first
    if(@establishment.nil?)
      redirect_to root_path, :flash => { :error => "Lugar ainda não foi avaliado. Por favor, avalie abaixo." }
    else
      redirect_to @establishment
    end
  end

  def help
  end

  def calculate_average_establishment(establishment)
    todasNotas = establishment.ratings.map do |rating|
      rating.average_rating
    end

    todasNotas.delete_if {|x| x == nil}

    return (todasNotas.sum/todasNotas.length).round(1)
  end

end
