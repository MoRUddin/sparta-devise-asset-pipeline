class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :name
      t.string :summary
      t.date :release_date
      t.integer :rating

      t.timestamps
    end
  end
end
