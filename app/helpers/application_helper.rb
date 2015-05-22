module ApplicationHelper

  def truncate(word)
    word.size > 20 ? "#{word[0..15]}..." : word
  end

  def monster_jobs?
    @monster_jobs.present?
  end

  def indeed_jobs?
    @indeed_jobs.present?
  end

  def simplyhired_jobs?
    @simplyhired_jobs.present?
  end

  def dice_jobs?
    @dice_jobs.present?
  end
end
