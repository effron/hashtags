module ApplicationHelper
  def flash_class(level)
    case level
      when 'notice' then "alert alert-info"
      when 'success' then "alert alert-success"
      when 'error' then "alert alert-danger"
      when 'alert' then "alert alert-warning"
    end
  end

  def at_root?
    request.fullpath == "/"
  end

  def parent_path
    result = request.fullpath.split("/")[0...-1].join("/")
    result = "/" if result.blank?
    result
  end

  def mapping_link(mapping)
    link_to "##{mapping.tag.content} (#{mapping.score})", child_path(mapping.content)
  end

  def child_path(slug)
    last_el = request.fullpath.split("/").last
    "/" + [last_el, slug].reject(&:blank?).join("/")
  end
end
