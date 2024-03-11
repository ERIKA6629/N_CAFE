class CreateReservationTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :reservation_times do |t|

      t.timestamps
      
      t.string :start_at
      t.string :end_at
      t.integer :business_hours
    end
  end
end
