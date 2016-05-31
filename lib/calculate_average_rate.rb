class CalculateAverageRate
  attr_accessor :evaluates

=begin
  def initialize
    @grades ||= []
    @@soma ||= 0
    @@qtd ||= 0
    @@media ||= 0
  end

  def calculate(grades)
    grades.each do |grade|
      grade.each_with_index do |(key, value), counter|
        if value != nil
          return value
        # @@soma = @@soma + grade[value]
        # @@qtd = @@qtd + 1
        end
      # return @media = @@soma/@@qtd
      end
    end
  end
=end

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
