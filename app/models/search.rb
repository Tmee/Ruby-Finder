class Search < ActiveRecord::Base

  def self.simplyhired_jobs
    rows = @simply_doc.xpath("//div[contains(@id, 'content')]//div[contains(@id, 'search_results')]//div[contains(@class, 'column_center_inner')]//div[contains(@class, 'results')]//ul//li//div[position() = 1]")
    collect_data(rows, "www.simplyhired.com")
  end

  def self.collect_data(rows, url)
    rows.collect do |row|
      {
        :title => row.xpath("h2//a").text.gsub(/\s{3}/, ''),
        :link  => "#{url}#{row.xpath("h2//a").attribute('href').value}",
        :company_name => row.xpath("div[contains(@class, 'company_location')]//h4").text
      }
    end
  end
end