  class Indeed

  def self.get_document(city, state)
    @indeed_doc = Nokogiri::HTML(open("http://www.indeed.com/jobs?q=ruby&l=#{city}%2C+#{state}"))
  end

  def self.jobs
    rows = @indeed_doc.xpath("//table//tr//td//table//tr//td[contains(@id ,'resultsCol')]//div[contains(@class, 'row  result')]")
    collect_data(rows[2..-2], "http://www.indeed.com")
  end

  def self.collect_data(rows, url)
    rows.collect do |row|
      if row.xpath("h2//a").empty?
        {
          :title => "Not a job, Just a bug... I'm workin' on it",
          :link => "http://www.addictinggames.com/action-games/free-rider-3-game.jsp",
          :company_name => "Don't click that link"
        }
      else
        {
          :title => row.xpath("h2//a").text.gsub(/\s{3}/, ''),
          :link  => "#{url}#{row.xpath("h2//a").attribute('href').value}",
          :company_name => row.xpath("span[contains(@class, 'company')]").text
        }
      end
    end
  end
end