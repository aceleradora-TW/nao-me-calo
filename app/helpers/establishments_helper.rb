module EstablishmentsHelper

  def shorten_description(description)
     truncate(description, length: 60)
  end

  def description_have_minimun_lenght?(rating)
    rating.description.length > 25
  end

end
