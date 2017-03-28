class SimplyHired

  def self.get_document(city, state)
    @simply_hired_doc = Nokogiri::HTML(open("http://www.simplyhired.com/search?q=ruby&l=#{city}%2C+#{state}"))
  end

  def self.jobs
    rows = @simply_hired_doc.xpath("//div[contains(@class, 'jobs')]//div[contains(@class, 'card')]")
    collect_data(rows, "www.simplyhired.com")
  end

  def self.collect_data(rows, url)
    rows.collect do |row|
      {
        :title => row.xpath("a").text.strip,
        :link  => "#{url}#{row.xpath("a/@href").text}",
        :company_name => row.xpath("h3//span[contains(@class, 'jobposting-company')]").first.text,
        :location => row.xpath("h3//span[contains(@class, 'jobposting-location')]").first.text
      }
    end
  end
end