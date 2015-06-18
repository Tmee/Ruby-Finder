require 'rails_helper'

RSpec.describe Dice, :type => :model do
  let(:response) do
    if file.ctime < (Date.today - 1)
      File.open((File.expand_path("../../xml_cassettes/dice.xml", __FILE__)).rewrite do
        Nokogiri::XML(open("https://www.dice.com/jobs?q=ruby&l=Denver%2C+CO"))
      end
    end
    file = File.read(File.expand_path("../../xml_cassettes/dice.xml", __FILE__))
    Nokogiri::XML(file)
  end

  describe "Document" do
    it "gets the correct document" do
      true
    end
  end

  describe "XPath" do

    it "finds the correct number of rows" do
      expect(response.xpath("//a")).to_not be_empty
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