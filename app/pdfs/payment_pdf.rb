class PaymentPdf < Prawn::Document
  
  def initialize(payments, view)
    super(top_margin: 70)
    font "#{Prawn::BASEDIR}/data/fonts/DejaVuSans.ttf"
    text I18n.t('mainmenu.payments'), size:30
    @payments = payments
    @view = view
    line_items
  end

  def line_items
    move_down 20
  	table line_item_rows do 
  	  row(0)
  	  columns(1.3).align = :right
  	  self.row_colors = ["DDDDDD", "FFFFFF"]
  	  self.header = true 
  	end
  end

  def line_item_rows
  	[[I18n.t('payments.payment_date'),
      I18n.t('payments.description'),
      I18n.t('payments.amount'),
      I18n.t('payments.name_of_shooter')]] +
    @payments.map do |item|
      [item.date,
    	 item.description,
    	 price(item.amount),
    	 item.by]
    end
  end

  def price(number)
    @view.number_to_currency(number, format: :'%n %u', separator: :',', delimiter: :' ', unit: :'zł')
  end
end

