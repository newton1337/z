# Preview all emails at http://localhost:3000/rails/mailers/score_mailer
class ScoreMailerPreview < ActionMailer::Preview
  def recommendation_mail_preview
    ScoreMailer.recommendation_email('test@example', 100)
  end
end
