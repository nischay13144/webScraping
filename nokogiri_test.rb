require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'watir-webdriver'

  
file = File.open("/tmp/file4.ods", "w")
@browser = Watir::Browser.new :firefox
b = [*2115..2584]
for j in b do

	url = "https://www.aasaanjobs.com/en/job/" << j.to_s
	@browser.goto(url)
	if @browser.text.include? "404"
		puts "This failed"
	else
		doc = Nokogiri::HTML(open(url))
		title = doc.at_css("title").text
		objects = []
		doc.css(".text-medium").each do |i|
			objects<<i.text.strip
		end


		a = [*1..14]
		file.write(title)
		for i in a do
			file.write(objects[i])
			file.write("\n")
		end
		file.write("\n")
	end
end
