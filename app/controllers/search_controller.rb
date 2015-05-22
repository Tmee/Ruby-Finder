class SearchController < ApplicationController

  def create
    if search_present?
      format_search
      get_html_docs(@city, @state)
      reset_params
      scrape_for_jobs
    end
  end

  def scrape_for_jobs
    @dice_jobs    = Dice.jobs
    @indeed_jobs  = Indeed.jobs
    @monster_jobs = Monster.jobs
    @simplyhired_jobs = SimplyHired.jobs
  end

  private

  def reset_params
    params.delete :city
    params.delete :state
  end

  def search_present?
    params[:city].present? || params[:state].present?
  end

  def format_search
    @city  = params[:city].capitalize.gsub(/\s/, '-')
    @state = params[:state].upcase.gsub(/\s/, '-')
  end

  def get_html_docs(city, state)
    Dice.get_document(city, state)
    Indeed.get_document(city, state)
    Monster.get_document(city, state)
    SimplyHired.get_document(city, state)
  end
end