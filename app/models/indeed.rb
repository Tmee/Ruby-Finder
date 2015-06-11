  class Indeed

  def self.get_document(city, state)
    @indeed_doc = Nokogiri::HTML(open("http://www.indeed.com/jobs?q=ruby&l=#{city}%2C+#{state}"))
  end

  def self.jobs
    rows = @indeed_doc.xpath("//table//tr//td//table//tr//td[contains(@id ,'resultsCol')]//div[contains(@itemtype, 'http://schema.org/JobPosting')]")
    collect_data(rows, "http://www.indeed.com")
  end

  def self.collect_data(rows, url)
    rows.collect do |row|
      {
        :title => row.at("h2").text.delete("\n"),
        :link  => "#{url}#{row.at("h2//a").attribute('href').value}",
        :company_name => row.at("span").text,
        :location => row.at("[@class = location]").text
      }
    end
  end
end