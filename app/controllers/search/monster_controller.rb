class MonsterController < ApplicationController

  def results
    if search_present?
      format_search
      get_html_docs(@city, @state)
      reset_params
      scrape_for_jobs
    end
  end

  def scrape_for_jobs
    render json: Dice.jobs
    @monster_jobs = Monster.jobs
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
    Monster.get_document(city, state)
  end
end