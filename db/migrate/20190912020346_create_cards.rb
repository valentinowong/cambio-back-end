class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.integer :pile_id
      t.string :image_url
      t.string :value
      t.string :suit
      t.string :code
      t.integer :points
      t.integer :position

      t.timestamps
    end
  end
end
