class SearchController < ApplicationController

  def create
    if params[:city].present? || params[:state].present?
      city  = params[:city].gsub(/\s{1}/, '-')
      state = params[:state].gsub(/\s{1}/, '-')
      get_html_docs(city, state)
      scrape_for_data
    end
  end

  def get_html_docs(city, state = '')
    @monster_doc = Nokogiri::HTML(open("http://jobsearch.monster.com/search/ruby_5?where=#{city}__2C-#{state}"))
    @indeed_doc  = Nokogiri::HTML(open("http://www.indeed.com/jobs?q=ruby&l=#{city}%2C+#{state}"))
    if city.empty?
      begin
        @simply_doc  = Nokogiri::HTML(open("http://www.simplyhired.com/search?q=ruby&l=#{state}"))
      rescue OpenURI::HTTPError
      else
        @simply_doc = []
      end
    else
      begin
        @simply_doc  = Nokogiri::HTML(open("http://www.simplyhired.com/search?q=ruby&l=#{city}%2C+#{state}"))
      rescue OpenURI::HTTPError
      else
        @simply_doc = []
      end
    end
  end

  def scrape_for_monster_jobs
    rows = @monster_doc.xpath("//div[contains(@class, 'leftContainer')]//div[contains(@id, 'primaryResults')]//table//tr[position() > 1]//td[position() = 2]//div[contains(@class, 'jobTitleContainer')]//a")
    collect_data(rows)
  end

  def scrape_for_indeed_jobs
    rows = @indeed_doc.xpath("//table//tr//td//table//tr//td[contains(@id ,'resultsCol')]//div[contains(@class, 'row  result')]//h2//a")
    collect_data(rows, "www.indeed.com")
  end

  def scrape_for_simplyhired_jobs
    if @simply_doc.present?
      rows = @simply_doc.xpath("//div[contains(@id, 'content')]//div[contains(@id, 'search_results')]//div[contains(@class, 'column_center_inner')]//div[contains(@class, 'results')]//ul//li//div[position() = 1]//h2//a")
      collect_data(rows, "www.simplyhired.com")
    end
  end


  private

  def scrape_for_data
    @monster_jobs     = scrape_for_monster_jobs
    @indeed_jobs      = scrape_for_indeed_jobs
    @simplyhired_jobs = scrape_for_simplyhired_jobs
  end

  def collect_data(rows, url = nil)
    jobs_array = []
    rows.collect do |row|
      detail = {}
      detail[:title] = row.text.gsub(/\s{3}/, '')
      detail[:link]  = "#{url}#{row.attribute('href').value}"
      jobs_array << detail
      end
    jobs_array
  end
end