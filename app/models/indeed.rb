class Indeed

  def self.get_document(city, state)
    @doc = Nokogiri::HTML(open("http://www.indeed.com/jobs?q=ruby&l=#{city}%2C+#{state}"))
  end

  def self.jobs
    rows = @doc.xpath("//table//tr//td//table//tr//td[contains(@id ,'resultsCol')]//div[contains(@class, 'row  result')]")
    collect_data(rows[2..-2], "www.indeed.com")
  end

  def self.collect_data(rows, url)
    rows.collect do |row|
      begin
        {
          :title => row.xpath("h2//a").text.gsub(/\s{3}/, ''),
          :link  => "#{url}#{row.xpath("h2//a").attribute('href').value}",
          :company_name => row.xpath("span[contains(@class, 'company')]").text
        }
      rescue
        {
          :title => row.xpath("h2//a").text.gsub(/\s{3}/, ''),
          :link  => "#{url}#{row.xpath("a").attribute('href').value}",
          :company_name => row.xpath("span[contains(@class, 'company')]").text
        }
      end
    end
  end
end