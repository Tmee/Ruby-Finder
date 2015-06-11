class ResultsController < ApplicationController

  def self.get_html_docs(city, state)
    Dice.get_document(city, state)
    Indeed.get_document(city, state)
    Monster.get_document(city, state)
    SimplyHired.get_document(city, state)
  end

  def self.scrape_for_jobs
    @dice_jobs    = Dice.jobs
    @indeed_jobs  = Indeed.jobs
    @monster_jobs = Monster.jobs
    @simplyhired_jobs = SimplyHired.jobs
  end
end