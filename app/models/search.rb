class Search

  def self.get_html_docs(city, state)
    Dice.get_document(city, state)
    Indeed.get_document(city, state)
    Monster.get_document(city, state)
    SimplyHired.get_document(city, state)
  end
end
