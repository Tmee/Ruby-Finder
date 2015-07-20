RSpec.describe Monster, :type => :model do


  let!(:document) do
    Nokogiri::HTML(open("http://jobsearch.monster.com/search/ruby_5?where=Denver__2C-CO"))
  end

  let!(:job_rows) do
    document.xpath("//div[contains(@class, 'leftContainer')]//div[contains(@id, 'primaryResults')]//table//tr[contains(@class, 'odd') or contains(@class, 'even')]")
  end

  describe "Nokogiri" do

    it "gets the correct document type" do
      expect(document.class).to equal(Nokogiri::HTML::Document)
    end

  end

  describe "Xpath" do

    it "finds the correct number of job rows" do
      expect(job_rows.count).to equal(25)
    end

    it "finds the job title" do
      title = job_rows.first.xpath("td[position() = 2]//div//a[position() = 1]").text.gsub(/\s{3}/, '')
      expect(title).not_to be_empty
    end

    it "finds the job link" do
      link = job_rows.first.xpath("td[position() = 2]//div//a[position() = 1]").attribute('href').value
      expect(link).to include("http://")
    end

    it "finds the company name" do
      company_name = job_rows.first.xpath("td[position() = 2]//div[contains(@class, 'companyContainer')]//a[position() = 2]").text
      expect(company_name).not_to be_empty
    end

    it "finds the job location" do
      location = job_rows.first.xpath("td[position() = 3]//div//a").text
      expect(location).not_to be_empty
    end

  end
end
