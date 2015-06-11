require 'nokogiri'
require 'net/http'
require 'open-uri'

class Page
	attr_reader :url 
  def initialize(url)
  	 @url = url
  	 @codea_website = Nokogiri::HTML(open("http://www.codea.mx/"))
		 
  end

  def fetch!
  	@response = Net::HTTP.get(URI(@url))
  	# @response = Net::HTTP.get("http://www.locomotion.mx/challenges/158") 
  end

  def links
  	@links = @codea_website.search(".nav-item > a")
  	@links.each do |i|
  		puts "#{i.inner_text}: #{i["href"]}"
  	end
  end

  def title
  	title = @codea_website.search("title").inner_text
  	title

  end
end

class Browser
  def run!

  	instance = Page.new("http://codea.mx")
		instance.fetch!
		puts instance.title
		instance.links
  end
end

Browser.new.run!

#reference : http://www.w3schools.com/cssref/css_selectors.asp
