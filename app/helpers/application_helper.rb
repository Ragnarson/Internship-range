module ApplicationHelper
  def change_to_currency(amount)
    number_to_currency(amount, separator: ",", delimiter: " ",
      format: "%n %u", locale: :pl)
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    onclick = "Contests.add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\");return false;"
    link_to name, "#", onclick: onclick
  end

  def sortable(column_name, link_title)
    css_class = column_name == sort_column ? "current #{sort_direction}" : nil
    direction = column_name == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to link_title, params.merge(sort: column_name, direction: direction, page: nil), {class: css_class}
  end

  def current_date
    Date.current.strftime("%Y-%m-%d")
  end

  def display_for_visible(attribute, placeholder_on_blank='-')
    attribute.blank? ? placeholder_on_blank : attribute
  end
end
