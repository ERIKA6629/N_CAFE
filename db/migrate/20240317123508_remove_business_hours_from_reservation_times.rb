class RemoveBusinessHoursFromReservationTimes < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservation_times, :business_hours, :integer
  end
end
