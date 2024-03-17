class AddNumberOfPeopleToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :number_of_people, :interger
    change_column_null :reservations, :number_of_people, false, 0
  end
end
