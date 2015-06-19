require 'rails_helper'

RSpec.describe Dice, :type => :model do
  let(:url) {"https://www.dice.com/jobs?q=ruby&l=Denver%2C+CO"}
  let(:document) {File.open(File.expand_path("../../xml_cassettes/dice.xml", __FILE__), "w+")}
  let(:response) do
    if true
      File.open(document) {}
      document << Nokogiri::HTML(open(url))
    end
    Nokogiri::XML(document)
  end

  describe "XML Document" do
    it "is not outdated" do
      document = File.open(File.expand_path("../../xml_cassettes/dice.xml", __FILE__))
      expect(DateTime.parse(document.ctime.to_s).to_date == Date.today).to be true
    end

    it "gets populated with correct url" do
      expect(url.include?("dice.com/jobs")).to be true
    end
  end

  describe "XPath" do

    it "finds the correct number of rows" do
      expect(response.at("a")).to be true
    end

    it "collects the title" do
      skip
    end

    it "collects the link" do
      skip
    end

    it "collects the comapny name" do
      skip
    end

    it "collects the location" do
      skip
    end
  end
end