module ApplicationHelper
  def sidebar_tab(name, link, type)
    selected_tag = params[:type].present? ? params[:type].to_sym : nil
    content_tag :li, link_to(name, link), :class => selected_tag == type ? "active" : nil
  end
end
