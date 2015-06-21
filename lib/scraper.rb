require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  attr_accessor :id, :name, :type

  def initialize(database)
    @database = database
  end

  def scrape
    html = open('pokemon_index.html').read
    doc = Nokogiri::HTML(html)
    cards = doc.search(".infocard-tall")
    cards.collect do |card| 
      card
      name = card.search("a.ent-name").first.text  
      type = card.search("a.itype").first.text
      sql = <<-SQL
        INSERT INTO pokemons (name, type)
        VALUES (?, ?)
      SQL
      @database.execute(sql, name, type) 
    end
  end

end 
