class SearchController < ApplicationController

  def create
    if search_present?
      format_search
      Search.get_html_docs(@city, @state)
      scrape_for_jobs
    end
  end


  private

  def search_present?
    params[:city].present? || params[:state].present?
  end

  def format_search
    @city  = params[:city].downcase.gsub(/\s/, '-')
    @state = params[:state].downcase.gsub(/\s/, '-')
  end

  def scrape_for_jobs
    @dice_jobs    = Dice.jobs
    @indeed_jobs  = Indeed.jobs
    @monster_jobs = Monster.jobs
    @simplyhired_jobs = SimplyHired.jobs
  end
end