module ActiveAdmin::ShowHelper

  def indicate_user(version)
    if version.whodunnit.nil?
      "Zmienione automatycznie"
    else
      user = User.find(version.whodunnit.to_i)
      if user && user.admin?
        "Zmienione przez: #{user.email} - admin"
      elsif user && !user.admin?
        "Zmienione przez: #{user.email}"
      else
        "Zmienione przez - brak danych"
      end
    end
  end

  def modification_description(version)
    if version.changeset.empty?
      modifications = ["Rekord usunięto"]
    else
      modifications = version.changeset.inject([]) do |mod, (key, value)|
        if value[0].nil?
          mod << "Podano '#{key}': #{value[1]};"
        else
          mod << "Zmieniono '#{key}': z '#{value[0]}' na '#{value[1]}';"
        end
      end
    end
    modifications
  end

  # def undo_link(to_revert, options = {})
  #   scope = options[:scope]
  #   also_to_revert = options[:also_to_revert]
  #   if scope
  #     elements = [to_revert.versions.scope.last]
  #     view_context.link_to("Cofnij akcję", revert_version_path(elements: elements), method: :post)
  #   else
  #     elements = [to_revert.versions.last]
  #     elements << also_to_revert.versions.last if also_to_revert.present?
  #     view_context.link_to("Cofnij akcję", revert_version_path(elements: elements), method: :post)
  #   end
  # end

end
