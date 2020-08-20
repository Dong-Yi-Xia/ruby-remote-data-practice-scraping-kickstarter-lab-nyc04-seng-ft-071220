require 'nokogiri'
# require 'pry'

#the project selector 
#project = kickstarter.css("li.project.grid_4").first

#h2 with a class of bbcard_name
# inside a strong tag 
# then inside an a tag
# project.css(" strh2.bbcard_nameong a")

# just the title
# project.css("h2.bbcard_name strong a").text

#image file link. By getting the attribute value  
# project.css("div.project-thumbnail a img").attribute("src").value

#the description
#project.css("p.bbcard_blurb").text

#the location 
#project.css("ul.project-meta li a span.location-name").text

#the % funded-- .gsub("%", "").to_i to remove the percent sign and convert it into an integer.
#project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i 


def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
 
  projects = {}
 
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
 
  # return the projects hash
  projects
end