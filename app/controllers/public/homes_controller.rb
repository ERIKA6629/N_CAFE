class Public::HomesController < ApplicationController
  
  def cafe_information
    @seats = Seat.all
  end

end
