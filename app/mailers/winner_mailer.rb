class WinnerMailer < ApplicationMailer
  # notify winner via email
  def new_winner_email(winner)
    @winner = winner
    @treasure_latitude = TREASURE_LAT
    @treasure_longitude = TREASURE_LNG
    mail(to: @winner.email, subject: "Congrats! you've found the treasure")
  end
end
