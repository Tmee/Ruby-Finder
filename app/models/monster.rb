class Monster

  def self.get_document(city, state)
    @monster_doc = Nokogiri::HTML(open("http://jobsearch.monster.com/search/ruby_5?where=#{city}__2C-#{state}"))
  end

  def self.jobs
    rows = @monster_doc.xpath("//div[contains(@class, 'leftContainer')]//div[contains(@id, 'primaryResults')]//table//tr[position() > 1]//td[position() = 2]")
    collect_data(rows)
  end

  def self.collect_data(rows)
    rows.collect do |row|
      {
        :title => row.xpath("div//a[position() = 1]").text.gsub(/\s{3}/, ''),
        :link  => row.xpath("div//a[position() = 1]").attribute('href').value,
        :company_name => row.xpath("div//a[position() = 3]").text.gsub(/\s{3}/, '')
      }
    end
  end
end