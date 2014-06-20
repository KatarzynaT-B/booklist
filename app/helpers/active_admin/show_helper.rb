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

end
