class ParseLineIntoHash
  attr_reader :input

  def self.call(*args)
    new(*args).call
  end
  
  def initialize(input)
    @input = input
  end

  def call
    {
      feature: tokenize_description,
      date_range: tokenize_dates,
      price: tokenize_price
    }
  end

  private

  def tokenize_price
    input.scan(/\d+\.\d{2}$/).first
  end

  def tokenize_dates
    matches = input.scan /\d{1,2}\/\d{1,2}/
    matches.join " - "
  end

  def tokenize_description
    matches = input.scan /[[:alpha:]]+/
    matches.join ' '
  end
end
