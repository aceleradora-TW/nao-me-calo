class CalculateAverageRate
  attr_accessor :evaluates

  def initialize
    @result ||= 0
    @counter ||= 0
  end

  def calculate_media(evaluates)
    evaluates.each do |key, value|
      unless value == nil
        @result = @result + value
      end
    end
    return @result / evaluates.length
  end

end
