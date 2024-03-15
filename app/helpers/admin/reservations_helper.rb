module Admin::ReservationsHelper
  def display_admin(email)
    return true if email == 'n_cafe@example.com'
  end
end
