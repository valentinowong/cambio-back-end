class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :status, :default => "Not Started"
      t.integer :phase, :default => 1

      t.timestamps
    end
  end
end
