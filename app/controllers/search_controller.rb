class SearchController < ApplicationController

  def create
    if search_present?
      format_search
      get_html_docs(@city, @state)
      scrape_for_jobs
    end
  end

  private

  def get_html_docs(city, state)
    Monster.get_document(city, state)
    # Search.get_html_docs(city, state)
  end

  def search_present?
    params[:city].present? || params[:state].present?
  end

  def format_search
    @city  = params[:city].gsub(/\s/, '-')
    @state = params[:state].gsub(/\s/, '-')
  end

  def scrape_for_jobs
    # @dice_jobs        = Search.dice_jobs
    # @indeed_jobs      = Search.indeed_jobs
    @monster_jobs     = Monster.jobs
    # @simplyhired_jobs = Search.simplyhired_jobs
  end
end
