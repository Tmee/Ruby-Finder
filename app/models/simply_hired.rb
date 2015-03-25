class SimplyHired

  def self.get_document(city, state)
    set_location(city, state)
    @s_hired_doc = Nokogiri::HTML(open("http://www.simplyhired.com/search?q=ruby&l=#{city}%2C+#{state}"))
  end

  def self.jobs
    rows = @s_hired_doc.xpath("//div[contains(@id, 'content')]//div[contains(@id, 'search_results')]//div[contains(@class, 'column_center_inner')]//div[contains(@class, 'results')]//ul//li//div[position() = 1]")
    valid_rows = check_valid(rows)
    collect_data(valid_rows, "www.simplyhired.com")
  end

  def self.collect_data(rows, url)
    rows.collect do |row|
      if row.xpath("h2//a").empty?
        binding.pry
      else
        {
          :title => row.xpath("h2//a").text.gsub(/\s{3}/, ''),
          :link  => "#{url}#{row.xpath("h2//a").attribute('href').value}",
          :company_name => row.xpath("div[contains(@class, 'company_location')]//h4").text
        }
      end
    end
  end

  private

  def self.set_location(city, state)
    @city  = city
    @state = state
  end

  def self.check_valid(rows)
    if rows.empty?
      puts "hit empty rows"
      get_document(@city, @state)
      binding.pry
      @s_hired_doc.xpath("//div['content']//div['search_results']//div['column_center_inner']//div['results']//ul//li//div[position() = 1]")
    else
      rows
    end
  end
end