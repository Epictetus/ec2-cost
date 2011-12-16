#encoding: utf-8
=begin
require 'money'
require 'money/bank/google_currency'
require 'json'
MultiJson.engine = :json_gem # or :yajl
Money.default_bank = Money::Bank::GoogleCurrency.new


doll = 1.to_money(:USD)
yen = doll.exchange_to(:JPY)

p yen.cents


RATE = yen.cents.to_f/100
=end

RATE = 78

class AWSPrice
  def to_month_doll(cost)
    ( cost * 24 * 31 ).truncate
  end

  def to_month_jpy(cost)
    to_month_doll cost * RATE
  end

  def print(arg)
    arg.each do |key, value|
      puts key.to_s + ': ' + to_month_jpy(value).to_s
    end
  end

  def to_a(arg)
    h = {}
    arg.each do |key, val|
      h[key] = to_month_jpy val
    end
    h
  end
end

h = {:small => 0.1, :large => 0.4, :extra_large => 0.8}

#a = AWSPrice.new.print( h )
