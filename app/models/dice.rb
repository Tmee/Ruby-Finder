class Dice

  def self.get_document(city, state)
    @dice_doc = Nokogiri::HTML(open("https://www.dice.com/jobs?q=ruby&l=#{city}%2C+#{state}"))
  end

  def self.jobs
    rows = @dice_doc.xpath("//div[contains(@id, 'resultSec')]//div[contains(@class, 'serp-result-content')]")
    collect_data(rows)
  end

  def self.collect_data(rows)
    rows.collect do |row|
        {
        :title => row.xpath("h3//a").text.gsub(/\s{3}/, ''),
        :link  => "#{row.xpath("h3//a").attribute('href').value}",
        :company_name => row.xpath("ul//li[contains(@class, 'employer')]//a").text
      }
    end
  end
end