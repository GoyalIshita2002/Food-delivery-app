class CreateSplitHours < ActiveRecord::Migration[7.0]
  def change
    create_table :split_hours do |t|
      t.time :start_at
      t.time :end_at
      t.references :open_hour, null: false, foreign_key: true

      t.timestamps
    end
  end
end
