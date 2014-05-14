module ApplicationHelper
  def change_to_currency(amount)
    number_to_currency(amount, separator: ",", delimiter: " ",
      format: "%n %u", locale: :pl)
  end
end
