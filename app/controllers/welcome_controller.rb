class WelcomeController < ApplicationController

  def index
    @establishments = Establishment.includes(:ratings).order("ratings.rating_date").last(5).reverse!
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

end
