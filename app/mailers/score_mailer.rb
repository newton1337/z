class ScoreMailer < ApplicationMailer
  default from: 'no.reply@futurepruf.com'

  def recommendation_email(email, score)
    @score = score
    mail(to: email, subject: 'Homescore: Example!')
  end
end
