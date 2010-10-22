module PostsHelper
  def build_tags_links(post)
    tags_html = ""
    post.tags.each do |tag|
      tags_html << "<a  href='/posts/tag/#{tag.name}'>#{tag.name.titleize}</a> "
    end
    tags_html
  end

  def edit_link(post)
    link = nil
    if can?(:update, post) && can?(:destroy, post) 
      "#{link_to 'Edit', edit_post_path(post)} | #{link_to 'Delete', post, :confirm => 'Are you sure?', :method => :delete}"
    end
  end

  def show_link(post)
    link_to_unless current_page?(:controller => 'posts', :action => 'new'),'Show', post do
      nil
    end
  end

  def back_link()
    link_to_unless current_page?(:controller => 'posts', :action => 'index'),'Back', posts_path do
      nil
    end
  end

  def build_navigation_links(back, other)
    if other.nil? && back.nil?
      ""
    elsif other.nil?
      back
    elsif back.nil?
      other
    else
      "#{other} | #{back}"
    end
  end

  def edit_and_back_links(post)
    edit = edit_link(post)
    back = back_link()
    build_navigation_links(back, edit)
  end

  def show_and_back_links(post)
    show = show_link(post)
    back = back_link()
    build_navigation_links(back, show)
  end
end
