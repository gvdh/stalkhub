require 'open-uri'
require 'nokogiri'
require 'geocoder'

class ScrapingGoogle

  def initialize(full_name, user_id,user_ip)
    @user_ip = user_ip
    @full_name = full_name
    user = User.find(user_id)
    @provider = Provider.create!(
      name: "google",
      user: user,
      expires_at: 999999999
    )
  end

  def basic_search
    url = "https://www.google.fr/search?q=\"#{@full_name}\""
    doc = Nokogiri::HTML(open(url).read)
    scrape_it(doc)
  end

  def search_with_city
    url = "https://www.google.fr/search?q=\"#{@full_name}\" #{@user_ip}"
    doc = Nokogiri::HTML(open(url).read)
    scrape_it(doc)
  end

  def search_with_city
    url = "https://www.google.fr/search?q=\"#{@full_name}\" #{@user_ip}"
    doc = Nokogiri::HTML(open(url).read)
    scrape_it(doc)
  end

  def scrape_it(doc)
    doc.search('.g').each do |rslt|
      if rslt.search('.r') && rslt.search('.r').size > 0
        title = rslt.search('.r').text()
        description = rslt.search('.st').text()
        link = rslt.search('.r > a').attr("href") if rslt.search('.r > a').size > 0
        if !(link.include?("/search?q="))
          result = Result.new(
            user: @user,
            category: "google",
            name: title,
            text: description,
            link: link.value.gsub("/url?q=", "")
            )
          result.provider = @provider
          result.save!
        end
      end
    end
  end
end


