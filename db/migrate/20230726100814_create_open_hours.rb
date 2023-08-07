class CreateOpenHours < ActiveRecord::Migration[7.0]
  def change
    create_table :open_hours do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.time :start_time
      t.time :end_time
      t.string :time_zone

      t.timestamps
    end
  end
end
