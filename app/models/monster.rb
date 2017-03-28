class Monster

  def self.get_document(city, state)
    @monster_doc = Nokogiri::HTML(open("https://www.monster.com/jobs/search/ruby_5?where=#{city}__2C-#{state}"))
  end

  def self.jobs
    rows = @monster_doc.xpath("//div[contains(@id, 'main')]//div//section//div[contains(@class, 'js_result_container')]")
    collect_data(rows)
  end

  def self.collect_data(rows)
    out = rows.collect do |row|
      {
        :title => row.xpath("article//div[contains(@class, 'jobTitle')]").text.strip,
        :link  => row.xpath("article//div[contains(@class, 'jobTitle')]//a/@href").text,
        :company_name => row.xpath("article//div[contains(@class, 'company')]").text.strip,
        :location => row.xpath("article//div//div[contains(@class, 'job-specs-location')]").text.strip
      }
    end
    out.delete_if { |k| k[:title].empty? }
  end
end