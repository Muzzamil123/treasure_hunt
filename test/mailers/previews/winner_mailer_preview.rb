class WinnerMailerPreview < ActionMailer::Preview
  def new_winner_email
    analytic = Analytic.new(email: "davyjones@flyngduthcman.com", latitude: 50.051227, longitude: 19.945704)

    WinnerMailer.with(winner: analytic).new_winner_email
  end
end
