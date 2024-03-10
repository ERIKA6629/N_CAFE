class Public::ReservationsController < ApplicationController
  
  def index
    @seat = Seat.find(params[:seat_id])
  end
  
  private
  
  def seat_id_get_params
    params.require(:reservation).permit(:seat_id)
  end
end
