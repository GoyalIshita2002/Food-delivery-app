class AddColumnToDocuments < ActiveRecord::Migration[7.0]
  def change
    add_column :documents, :driver_id, :integer
  end
end
