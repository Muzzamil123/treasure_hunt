class WinnerMailer < ApplicationMailer

  def new_winner_email
    @winner = params[:winner]
    mail(to: @winner.email, subject: "You won the treasure hunt")
  end

end
