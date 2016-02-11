class ScoreController < ApplicationController
  def another
  end

  def test
    @score = 0
    @dampness_scale = 0

    maintenance_score = Maintenance.new(params[:maintained]).score

    if params[:condensation] == 'yes'
      @dampness_scale += 5
    end

    fan = (params[:shower_fan] == 'yes') ? true : false
    shower_score = 0
    frequency = params[:shower_freq]

    if params[:occupants] == '1-3'
      if frequency == '1-5'
        if fan
          shower_score = -1
        else
          @dampness_scale += 3
          shower_score = -3
        end
      elsif frequency == '6-10'
        if fan
          shower_score = -2
        else
          @dampness_scale += 5
          shower_score = -4
        end
      end
    elsif params[:occupants] == '4-6'
    elsif params[:occupants] == '6+'
    end


    @score += maintenance_score
    @score += shower_score

    ScoreMailer.recommendation_email(params[:email], @score).deliver_now
  end
end

class Maintenance
  def initialize(raw_form_input)
    determine_effect(raw_form_input)
  end

  def score
    @effect
  end

  private

  def determine_effect(raw_form_input)
    case raw_form_input.downcase
    when 'expert'
      @effect = 5
    when 'somewhat'
      @effect = -5
    when 'deferred'
      @effect = -10
    end
  end
end
