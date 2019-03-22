require 'HTTParty'
require 'nokogiri'
require 'open-uri'
require 'byebug'

class Scraper
  attr_accessor :parse_page

  def initialize
    doc = HTTParty.get('https://store.nike.com/us/en_us/pw/new-mens/meZ7pu?ipp=120')
    @parse_page ||= Nokogiri::HTML(doc)
    byebug
    
  end


  def self.get_names
    names = item_container.css("product-name").css("p").children.map {|name| name.text }.compact
  end

  def self.get_prices
    prices = item_container.css("product-name").css("span.local").children.map {|price| price.text }.compact
  end

  def self.item_container
    @parse_page.css(".grid-item-info")
  end

end


scraper = Scraper.new

names = get_names
prices = get_prices

(0..prices.size).each do |index|
  p "- - - index: #{index + 1} - - -"
  p "Name: #{names[index]} | price: #{prices[index]}"
end