class AddDayOnOpenHour < ActiveRecord::Migration[7.0]
  def change
    add_column :open_hours, :day, :string
  end
end
