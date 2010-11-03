module Admin::ParentsHelper

  def address(person)
    output = "#{person.address1}<br />"
    output << "#{person.address2}<br />" if !person.address2.blank?
    output << "#{person.city}, #{person.state} #{person.zip}"
  end
  
  def format_phone(phone)
    phone.sub(/^1/, '').gsub(/\D/, '').sub(/^([\d]{3})([\d]{3})([\d]{4})$/, '(\1) \2-\3')
  end

end