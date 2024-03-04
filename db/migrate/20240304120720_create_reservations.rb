class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      
      t.timestamps
      
      t.integer :customer_id, null: false
      t.integer :seat_id, null: false
      t.integer :reservation_time_id, null: false
      t.date :start_time, null: false
      t.string :comment
      t.integer :number_of_people, null: false
    end
  end
end
