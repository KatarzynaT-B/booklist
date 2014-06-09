module ApplicationHelper

  def undo_link(to_revert, options = {})
    scope = options[:scope]
    also_to_revert = options[:also_to_revert]
    if scope
      elements = [to_revert.versions.scope.last]
      view_context.link_to("Cofnij akcję", revert_version_path(elements: elements), method: :post)
    else
      elements = [to_revert.versions.last]
      elements << also_to_revert.versions.last if also_to_revert.present?
      view_context.link_to("Cofnij akcję", revert_version_path(elements: elements), method: :post)
    end
  end

end
