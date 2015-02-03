class CreateSearch < ActiveRecord::Migration
  def change
    create_table :search do |t|
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
