require 'rails_helper'
require 'vcr_setup'

RSpec.describe Dice, :type => :model do

  describe "gets correct response" do
    it "has job elements" do
      VCR.use_cassette "dice" do
        response = HTTPClient.get('https://www.dice.com/jobs?l=Denver,%20CO&q=ruby')
        expect(response.body).to include('serp-result-content')
      end
    end

    it "has the correct number of job elements" do
      VCR.use_cassette "dice" do
        response = HTTPClient.get('https://www.dice.com/jobs?l=Denver,%20CO&q=ruby')
        expect(response.body.split('serp-result-content').count).to equal(61)
      end
    end
  end
end