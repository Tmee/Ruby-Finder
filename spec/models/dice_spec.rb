RSpec.describe Dice, :type => :model do

  let!(:document) do
    Nokogiri::HTML(open("https://www.dice.com/jobs?q=ruby&l=Denver%2C+CO"))
  end

  let!(:job_rows) do
    document.xpath("//div[contains(@id, 'resultSec')]//div[contains(@id , 'search-results-control')]//div[contains(@id, 'serp')]//div[contains(@class, 'serp-result-content')]")
  end

  describe "Nokogiri" do

    it "gets the correct document type" do
      expect(document.class).to equal(Nokogiri::HTML::Document)
    end

  end

  describe "Xpath" do

    it "finds the correct number of job rows" do
      expect(job_rows.count).to equal(30)
    end

    it "finds the job title" do
      title = job_rows.first.xpath("h3//a").text.gsub(/\s{3}/, '')
      expect(title).not_to be_empty
    end

    it "finds the job link" do
      link = job_rows.first.xpath("h3//a").attribute('href').value
      expect(link).to include("https://")
    end

    it "finds the company name" do
      company_name = job_rows.first.xpath("ul//li[contains(@class, 'employer')]//a").text
      expect(company_name).not_to be_empty
    end

    it "finds the job location" do
      location = job_rows.first.xpath("ul//li[contains(@class, 'location')]").text
      expect(location).not_to be_empty
    end

  end
end