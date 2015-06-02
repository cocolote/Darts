class CreatePlayer < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.integer :points, default: 0
      t.integer :game_id, null: false

      t.timestamps null: false
    end
  end
end
