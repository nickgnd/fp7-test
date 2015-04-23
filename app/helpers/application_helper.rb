module ApplicationHelper

  def sortable(column, model, default, search = nil, title = nil)
    title ||= column.titleize
    css_class = column == sort_column(model, default) ? "current #{sort_direction}" : nil
    direction = column == sort_column(model, default) && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction, :search => search}, {:class => css_class}
  end

end
