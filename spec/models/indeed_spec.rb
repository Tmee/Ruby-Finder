RSpec.describe Indeed, :type => :model do

  let!(:document) do
    Nokogiri::HTML(open("http://www.indeed.com/jobs?q=ruby&l=Denver%2C+CO"))
  end

  let!(:job_rows) do
    document.xpath("//table//tr//td//table//tr//td[contains(@id ,'resultsCol')]//div[contains(@itemtype, 'http://schema.org/JobPosting')]")
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
      title = job_rows.first.at("h2").text.delete("\n")
      expect(title).not_to be_empty
    end

    it "finds the job link" do
      link = job_rows.first.at("h2//a").attribute('href').value
      expect(link).not_to be_empty
    end

    it "finds the company name" do
      company_name = job_rows.first.at("span").text
      expect(company_name).not_to be_empty
    end

    it "finds the job location" do
      location = job_rows.first.at("[@class = location]").text
      expect(location).not_to be_empty
    end

  end
end