require 'open-uri'
require 'nokogiri'



Ingredient.destroy_all
Cocktail.destroy_all

url = "https://www.atelier-cocktail.com/recettes-cocktails-top25/"
html_file = open(url)
doc = Nokogiri::HTML(html_file)




doc.search("#cocktails-listing li").each do |cocktail|
  image_url = cocktail.search("img")[0].attr("src")
  name = cocktail.search(".top25")[0].text
  if cocktail.search("p")[0]
    description = cocktail.search("p")[0].text.strip
  else
    description = "no desc"
  end
  Cocktail.create!(name: name, description: description, image_url: image_url)
end

ingredients = %w(lemon ice mint leaves redbull jagermeister sugar tonic gin rhum)
ingredients.each { |ingredient| Ingredient.create(name: ingredient) }


