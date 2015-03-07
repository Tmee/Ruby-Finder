class Search < ActiveRecord::Base

  def self.get_html_docs(city, state = '')
    @dice_doc    = Nokogiri::HTML(open("https://www.dice.com/jobs?q=ruby&l=#{city}%2C+#{state}"))
    @indeed_doc  = Nokogiri::HTML(open("http://www.indeed.com/jobs?q=ruby&l=#{city}%2C+#{state}"))
    @simply_doc  = Nokogiri::HTML(open("http://www.simplyhired.com/search?q=ruby&l=#{city}%2C+#{state}"))
    @monster_doc = Nokogiri::HTML(open("http://jobsearch.monster.com/search/ruby_5?where=#{city}__2C-#{state}"))
  end

  def self.dice_jobs
    rows = @dice_doc.xpath("//div[contains(@id, 'resultSec')]//div[contains(@class, 'serp-result-content')]//a")
    collect_data(rows)
  end

  def self.indeed_jobs
    rows = @indeed_doc.xpath("//table//tr//td//table//tr//td[contains(@id ,'resultsCol')]//div[contains(@class, 'row  result')]//h2//a")
    collect_data(rows, "www.indeed.com")
  end

  def self.simplyhired_jobs
    rows = @simply_doc.xpath("//div[contains(@id, 'content')]//div[contains(@id, 'search_results')]//div[contains(@class, 'column_center_inner')]//div[contains(@class, 'results')]//ul//li//div[position() = 1]//h2//a")
    collect_data(rows, "www.simplyhired.com")
  end

  def self.monster_jobs
    rows = @monster_doc.xpath("//div[contains(@class, 'leftContainer')]//div[contains(@id, 'primaryResults')]//table//tr[position() > 1]//td[position() = 2]")
    collect_data(rows)
  end

  def self.collect_data(rows, url = nil)
    rows.collect do |row|
      {
        :title => row.xpath("div[contains(@class, 'jobTitleContainer')]//a").text.gsub(/\s{3}/, ''),
        :link  => "#{url}#{row.xpath("div[contains(@class, 'jobTitleContainer')]//a").attribute('href').value}",
        :company_name => row.xpath("div[contains(@class, 'companyContainer')]//a[title]")
      }
    end
  end
end