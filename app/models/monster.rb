class Monster

  def self.get_document(city, state)
    @monster_doc = Nokogiri::HTML(open("http://jobsearch.monster.com/search/ruby_5?where=#{city}__2C-#{state}"))
  end

  def self.jobs
    rows = @monster_doc.xpath("//div[contains(@class, 'leftContainer')]//div[contains(@id, 'primaryResults')]//table//tr[contains(@class, 'odd') or contains(@class, 'even')]")
    collect_data(rows)
  end

  def self.collect_data(rows)
    rows.collect do |row|
      {
        :title => row.xpath("td[position() = 2]//div//a[position() = 1]").text.gsub(/\s{3}/, ''),
        :link  => row.xpath("td[position() = 2]//div//a[position() = 1]").attribute('href').value,
        :company_name => row.xpath("td[position() = 2]//div[contains(@class, 'companyContainer')]//a[position() = 2]").text,
        :location => row.xpath("td[position() = 3]//div//a").text
      }
    end
  end
end