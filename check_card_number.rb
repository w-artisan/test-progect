# return @checked card number
class CheckCardNumber
  attr_accessor :card_number

  def initialize(card_number)
    @card_number = card_number
  end

  def output
    if (card_provider_check.is_a? String) && card_num_check
      "Card Provider - #{card_provider_check}. Card is valid"
    elsif card_provider_check.is_a? String
      "Card Provider - #{card_provider_check}. Card is NOT valid"
    elsif @card_number.numeric?
      'Not supported card provider'
    else
      'Not numeric input'
    end
  end

  def card_provider_check
    case @card_number
    when /^3[47]\d{13}$/ then 'AMEX'
    when /^6011\d{12}|650\d{13}$/ then 'Discover'
    when /^5\d{15}|36\d{14}$/ then 'MasterCard'
    when /^4\d{12}(\d{3})?$/ then 'Visa'
    else
      false
    end
  end

  def card_num_check
    (@card_number.to_s.reverse.split(//).each_slice(2).flat_map do |a, b|
      [a.to_i, 2 * b.to_i]
    end
       .join.split(//).map(&:to_i).reduce(:+) % 10).zero?
  end
end

# Helper for checking if numeric
class String
  def numeric?
    !Float(self).nil?
  rescue StandardError
    false
  end
end
