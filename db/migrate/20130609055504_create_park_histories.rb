class CreateParkHistories < ActiveRecord::Migration
  def change
    create_table :park_histories do |t|
      t.string :plate_number
      t.integer :stall_id
      t.integer :is_out

      t.timestamps
    end
  end
end
