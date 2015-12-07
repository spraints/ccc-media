module ApplicationHelper
  def page_title(new_title = nil)
    @page_title = new_title || @page_title
  end
end
