class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do|t|
      t.string  :first_name
      t.string  :last_name
      t.string  :team
      t.string  :position
      t.integer :points
    end
  end
end
