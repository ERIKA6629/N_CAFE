class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    @reservation_times = ReservationTime.all
    @seats = Seat.all
  end

end
