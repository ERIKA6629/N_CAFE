class RemoveNumberOfPeopleFromReservations < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservations, :number_of_people, :integer
  end
end
