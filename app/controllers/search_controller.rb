class SearchController < ApplicationController

  def create
    if params[:city].present? || params[:state].present?
      get_html_docs(params[:city], params[:state])
      @monster_jobs = scrape_for_monster_jobs
      @indeed_jobs  = scrape_for_indeed_jobs
      @simplyhired_jobs  = scrape_for_simplyhired_jobs
    end
  end

  def get_html_docs(city, state = '')
    @monster_doc = Nokogiri::HTML(open("http://jobsearch.monster.com/search/ruby_5?where=#{city}__2C-#{state}"))
    @indeed_doc  = Nokogiri::HTML(open("http://www.indeed.com/jobs?q=ruby&l=#{city}%2C+#{state}"))
    @simply_doc  = Nokogiri::HTML(open("http://www.simplyhired.com/search?q=ruby&l=#{city}%2C+#{state}"))
  end

  def scrape_for_monster_jobs
    rows = @monster_doc.xpath("//div[contains(@class, 'leftContainer')]//div[contains(@id, 'primaryResults')]//table//tr[position() > 1]//td[position() = 2]//div[contains(@class, 'jobTitleContainer')]//a")
    jobs_array = []
    rows.collect do |row|
      detail = {}
      detail[:title] = row.text.gsub(/\s{3}/, '')
      detail[:link]  = row.attribute('href').value
      jobs_array << detail
      end
    jobs_array
  end

  def scrape_for_indeed_jobs
    rows = @indeed_doc.xpath("//table//tr//td//table//tr//td[contains(@id ,'resultsCol')]//div[contains(@class, 'row  result')]//h2//a")
    jobs_array = []
    rows.collect do |row|
      detail = {}
      detail[:title] = row.text.gsub(/\s{3}/, '')
      detail[:link]  = "www.indeed.com#{row.attribute('href').value}"
      jobs_array << detail
      end
    jobs_array
  end

  def scrape_for_simplyhired_jobs
    rows = @simply_doc.xpath("//div[contains(@id, 'content')]//div[contains(@id, 'search_results')]//div[contains(@class, 'column_center_inner')]//div[contains(@class, 'results')]//ul//li//div[position() = 1]//h2//a")
    jobs_array = []
    rows.collect do |row|
      detail = {}
      detail[:title] = row.text.gsub(/\s{3}/, '')
      detail[:link]  = "www.simplyhired.com#{row.attribute('href').value}"
      jobs_array << detail
      end
    jobs_array
  end
end