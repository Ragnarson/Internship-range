module AddressHelper
  def display_address(a)
    "#{a.street} #{a.building}#{('/' + a.flat.to_s) if a.flat},
    #{a.zip_code} #{a.city}"
  end
end
