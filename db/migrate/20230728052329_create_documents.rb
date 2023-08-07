class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.string :name
      t.references :documenter, polymorphic: true, null: false

      t.timestamps
    end
  end
end
