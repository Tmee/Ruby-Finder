require 'rails_helper'
require 'vcr_setup'

RSpec.describe Dice, :type => :model do
  VCR.use_cassette 'fixtures/vcr_cassettes' do
    let(:response) do
      Net::HTTP.get_response(URI('https://www.dice.com/jobs?q=ruby&l=Denver%2C+CO'))
    end
  end

  describe "Response" do
    describe "the response has job data" do
      it "has entire job div" do
        expect(response.body).to include('serp-result-content')
      end

      it "has the correct number of jobs" do
        expect(response.body).to_not be_true
      end
    end
  end

  describe "XPaths" do
    it "gets the job title" do
      true
    end
  end


end
