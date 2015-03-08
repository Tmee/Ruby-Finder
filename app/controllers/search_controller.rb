class SearchController < ApplicationController

  def create
    if search_present?
      format_search
      get_html_docs(@city, @state)
      scrape_for_jobs
    end
  end


  private

  def search_present?
    params[:city].present? || params[:state].present?
  end

  def format_search
    @city  = params[:city].gsub(/\s/, '-')
    @state = params[:state].gsub(/\s/, '-')
  end

  def get_html_docs(city, state)
    Dice.get_document(city, state)
    Indeed.get_document(city, state)
    Monster.get_document(city, state)
    SimplyHired.get_document(city, state)
  end

  def scrape_for_jobs
    @dice_jobs    = Dice.jobs
    @indeed_jobs  = Indeed.jobs
    @monster_jobs = Monster.jobs
    @simplyhired_jobs = SimplyHired.jobs
  end
end