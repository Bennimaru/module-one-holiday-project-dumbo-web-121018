class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do|t|
      t.string  :name
      t.integer :user_id
      t.integer :player_id
      t.datetime  :game_day
      t.timestamps
    end
  end
end
