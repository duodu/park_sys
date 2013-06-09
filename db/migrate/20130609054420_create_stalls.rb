class CreateStalls < ActiveRecord::Migration
  def change
    create_table :stalls do |t|
      t.string :location
      t.integer :is_idle

      t.timestamps
    end
  end
end
