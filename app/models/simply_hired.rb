class SimplyHired

  def self.get_document(city, state)
    @simply_hired_doc = Nokogiri::HTML(open("http://www.simplyhired.com/search?q=ruby&l=#{city}%2C+#{state}"))
  end

  def self.jobs
    rows = @simply_hired_doc.xpath("//div[contains(@id, 'content')]//div[contains(@id, 'search_results')]//div[contains(@id, 'column_center')]//div[contains(@class, 'column_center_inner')]//div[contains(@class, 'results')]//ul//li//div[contains(@class, 'job')]")
    collect_data(rows, "www.simplyhired.com")
  end

  def self.collect_data(rows, url)
    rows.collect do |row|
      {
        :title => row.at("h2//a").text.gsub(/\s{3}/, ''),
        :link  => "#{url}#{row.at("h2//a").attribute('href').value}",
        :company_name => row.at("h4").text
      }
    end
  end
end