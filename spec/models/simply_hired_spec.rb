RSpec.describe SimplyHired, :type => :model do

  let!(:document) do
    Nokogiri::HTML(open("http://www.simplyhired.com/search?q=ruby&l=Denver%2C+CO"))
  end

  let!(:job_rows) do
    document.xpath("//div[contains(@id, 'content')]//div[contains(@id, 'search_results')]//div[contains(@id, 'column_center')]//div[contains(@class, 'column_center_inner')]//div[contains(@class, 'results')]//ul//li//div[contains(@class, 'job')]")
  end

  describe "Nokogiri" do

    it "gets the correct document type" do
      expect(document.class).to equal(Nokogiri::HTML::Document)
    end

  end

  describe "Xpath" do

    it "finds the correct number of job rows" do
      expect(job_rows.count).to equal(10)
    end

    it "finds the job title" do
      title = job_rows.first.at("h2//a").text.gsub(/\s{3}/, '')
      expect(title).not_to be_empty
    end

    it "finds the job link" do
      link = job_rows.first.at("h2//a").attribute('href').value
      expect(link).not_to be_empty
    end

    it "finds the company name" do
      company_name = job_rows.first.at("h4").text
      expect(company_name).not_to be_empty
    end

    it "finds the job location" do
      location = job_rows.first.at("[@class = location]").text.strip.split.join
      expect(location).not_to be_empty
    end

  end
end