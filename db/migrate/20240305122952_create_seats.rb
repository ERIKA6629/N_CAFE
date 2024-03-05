class CreateSeats < ActiveRecord::Migration[6.1]
  def change
    create_table :seats do |t|

      t.timestamps
      
      t.string :name
      t.integer :limit_number
      
    end
  end
end
