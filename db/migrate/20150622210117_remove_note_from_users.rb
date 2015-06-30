class RemoveNoteFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :note, :text
  end
end
