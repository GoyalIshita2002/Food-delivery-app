class CreateOpenDays < ActiveRecord::Migration[7.0]
  def change
    create_table :open_days do |t|
      t.string :day

      t.timestamps
    end
  end
end
