require 'nokogiri'
require 'open-uri'

class HomeController < ApplicationController
  def index
  end
  
  def get_currencies
    @doc = Nokogiri::XML(open("http://www.cbr.ru/scripts/XML_daily.asp"))
    @doc.css('Valute').each do |item|
      charcode = item.at('CharCode').text
      nominal = item.at('Nominal').text.to_f
      value = item.at('Value').text.sub(',', '.').to_f / nominal
      
      hash = {
        'charcode' => charcode,
        'value' => value
      }
      
      c = Currency.find_by_charcode(charcode)
      if c.nil?
        c = Currency.new(hash)
        c.save
      else
        c.update_attributes(hash)
      end  
    end
  end
  
end
