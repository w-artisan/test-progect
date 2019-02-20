require 'spec_helper'
require './check_card_number'

RSpec.describe CheckCardNumber do
  # output ----------------
  it 'Check Output - AMEX' do
    @checked_num = CheckCardNumber.new '377135197869836'
    expect(@checked_num.output).to eq 'Card Provider - AMEX. Card is valid'
    @checked_num = CheckCardNumber.new '377135197869830'
    expect(@checked_num.output).to eq 'Card Provider - AMEX. Card is NOT valid'
  end

  it 'Check Output - Discover' do
    @checked_num = CheckCardNumber.new '6011485740892648'
    expect(@checked_num.output).to eq 'Card Provider - Discover. Card is valid'
    @checked_num = CheckCardNumber.new '6011485740892600'
    expect(@checked_num.output).to eq 'Card Provider - Discover. Card is NOT valid'
  end

  it 'Check Output - MasterCard' do
    @checked_num = CheckCardNumber.new '5354577426571194'
    expect(@checked_num.output).to eq 'Card Provider - MasterCard. Card is valid'
    @checked_num = CheckCardNumber.new '5354577426571100'
    expect(@checked_num.output).to eq 'Card Provider - MasterCard. Card is NOT valid'
  end

  it 'Check Output - VISA' do
    @checked_num = CheckCardNumber.new '4219245340017060'
    expect(@checked_num.output).to eq 'Card Provider - Visa. Card is valid'
    @checked_num = CheckCardNumber.new '4219245340017000'
    expect(@checked_num.output).to eq 'Card Provider - Visa. Card is NOT valid'
  end

  it 'Check Output - Not Supported Card Provider' do
    @checked_num = CheckCardNumber.new '0000245340017060'
    expect(@checked_num.output).to eq 'Not supported card provider'
  end

  it 'Check Output - Not numeric input' do
    @checked_num = CheckCardNumber.new 'test'
    expect(@checked_num.output).to eq 'Not numeric input'
  end
  # card_provider_check ---------------------

  it 'Check Card provider AMEX' do
    @checked_num = CheckCardNumber.new '341111111111111'
    expect(@checked_num.card_provider_check).to eq 'AMEX'
    @checked_num = CheckCardNumber.new '371111111111111'
    expect(@checked_num.card_provider_check).to eq 'AMEX'
  end

  it 'Check Card provider Discover' do
    @checked_num = CheckCardNumber.new '6011111111111111'
    expect(@checked_num.card_provider_check).to eq 'Discover'
    @checked_num = CheckCardNumber.new '6501111111111111'
    expect(@checked_num.card_provider_check).to eq 'Discover'
  end

  it 'Check Card provider MasterCard' do
    @checked_num = CheckCardNumber.new '5111111111111111'
    expect(@checked_num.card_provider_check).to eq 'MasterCard'
    @checked_num = CheckCardNumber.new '3601111111111111'
    expect(@checked_num.card_provider_check).to eq 'MasterCard'
  end

  it 'Check Card provider Visa' do
    @checked_num = CheckCardNumber.new '4111111111111111'
    expect(@checked_num.card_provider_check).to eq 'Visa'
    @checked_num = CheckCardNumber.new '4111111111111111'
    expect(@checked_num.card_provider_check).to eq 'Visa'
  end

  it 'Check Card provider false' do
    @checked_num = CheckCardNumber.new '9111111111111111'
    expect(@checked_num.card_provider_check).to eq false
  end

  it 'Check Card number Luhn algorithm' do
    @checked_num = CheckCardNumber.new '9111111111111111'
    expect(@checked_num.card_num_check).to eq false
    @checked_num = CheckCardNumber.new '4219245340017060'
    expect(@checked_num.card_num_check).to eq true
  end
end
