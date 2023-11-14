class CreateCustomerFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :customer_feedbacks do |t|
      t.references :order, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.integer :status

      t.timestamps
    end
  end
end
