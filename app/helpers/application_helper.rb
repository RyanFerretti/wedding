# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper
  def render_partial_layout(default)
    begin
      render :partial => "layouts/#{default}"
    rescue ActionView::MissingTemplate
      nil
    end
  end

  def build_month_archive_display(key)
    date_val = key.split("/")
    "#{Date::MONTHNAMES[date_val[1].to_i]} #{date_val[0]}"
  end

  def current_active_link(name)
    "<span class=\"active\">#{name}</span>"
  end
end
