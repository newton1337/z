module ApplicationHelper
  def question_id(index, identifier)
    "questions[#{index}][#{identifier}]"
  end

  def multi_question_id(index, group, identifier)
    "questions[#{index}][#{group}][#{identifier}]"
  end

  def question_html(index, identifier)
    "id=#{question_id(index, identifier)} name=#{question_id(index, identifier)}"
  end

  def multi_quesiton_html(index, group, identifier, required=false)
    html = "id=#{multi_question_id(index, group, identifier)} name=#{multi_question_id(index, group, identifier)}"

    if required
      html += " required=required"
    end

    html
  end

  def build_radios(array, index, identifier, required=false)
    radios = []
    if array.is_a? Array
      array.each do |radio|
        r = required ? 'required="required"' : ''
        value = radio.downcase
        radios << "<label><input type=\"radio\" value=\"#{value}\" #{question_html(index, identifier)} #{r}> #{radio}</label>"
      end
    else
      array.each do |value, radio|
        r = required ? 'required="required"' : ''
        radios << "<label><input type=\"radio\" value=\"#{value}\" #{question_html(index, identifier)} #{r}> #{radio}</label>"
      end
    end

    radios.join('').html_safe
  end

  def build_checkboxes(hash, index, identifier, required=false)
    boxes = []
    hash.each do |value, label|
      r = required ? 'required="required"' : ''
      boxes << "<label><input type=\"checkbox\" value=\"#{value}\" #{question_html(index, identifier)} #{r}> #{label}</label>"
    end

    boxes.join('').html_safe
  end
end
