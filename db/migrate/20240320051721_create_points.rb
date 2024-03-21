class CreatePoints < ActiveRecord::Migration[6.1]
  def change
    create_table :points do |t|

      t.integer :customer_id, null: false
      t.timestamps
    end
  end
end
