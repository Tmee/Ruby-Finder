class SearchController < ApplicationController

  def create
    get_html_doc(params[:city], params[:state])
    @jobs = scrape_for_jobs
  end

  def get_html_doc(city, state)
    @doc  = Nokogiri::HTML(open("http://jobsearch.monster.com/search/ruby_5?where=#{city}__2C-#{state}"))
  end

  def scrape_for_jobs
    rows = @doc.xpath("//div[contains(@class, 'leftContainer')]//div[contains(@id, 'primaryResults')]//table//tr[position() > 1]//td[position() = 2]//div[contains(@class, 'jobTitleContainer')]//a")
    jobs_array = []
    rows.collect do |row|
      detail = {}
      detail[:title] = row.text.gsub(/\s{3}/, '')
      detail[:link]  = row.attribute('href').value
      jobs_array << detail
      end
    jobs_array
  end
end





    # titles = @doc.xpath("//div[contains(@class, 'leftContainer')]//div[contains(@id, 'primaryResults')]//table//tr[position() > 1]//td[position() = 2]//div[contains(@class, 'jobTitleContainer')]//a").map {|x| x.text.gsub(/\s{3}/, '')}
    # links  = @doc.xpath("//div[contains(@class, 'leftContainer')]//div[contains(@id, 'primaryResults')]//table//tr[position() > 1]//td[position() = 2]//div[contains(@class, 'jobTitleContainer')]//a").map {|x|x.attribute('href').value}
