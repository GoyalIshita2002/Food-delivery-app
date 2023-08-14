class AddPopularToDish < ActiveRecord::Migration[7.0]
  def change
    add_column :dishes, :is_popular, :boolean, default: false
  end
end
