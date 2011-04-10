module ApplicationHelper
  def sidebar_tab(name, link, type)
    content_tag :li, link_to(name, link), :class => @current_tab == type ? "#{type} active" : type
  end
end
