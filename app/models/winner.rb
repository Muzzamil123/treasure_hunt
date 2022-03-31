class Winner < ApplicationRecord
  #validations
  validates :email, :last_location, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :check_winner_record?

  # callbacks
  after_create :notify_winner

  private
  # checking if winner is already present in the list
  def check_winner_record?
    already_won = Winner.find_by(email: email)
    if already_won.present?
      errors.add(:winner, "is already present")
    end
  end
  # notify winner and send treasure location
  def notify_winner
    WinnerMailer.new_winner_email(self).deliver_later
  end
end
