ActiveAdmin.register PaperTrail::Version do
  actions :all, except: [:new, :edit, :destroy]

  scope :all, default: true
  scope :books
  scope :users
  scope :user_booklists

  filter :whodunnit, label: 'Zmiany użytkownika'
  filter :created_at, label: 'Zmiany z dnia'

  index do
    column "ID", sortable: :id do |version|
      link_to "#{version.id}", admin_paper_trail_version_path(version)
    end
    column "Typ", sortable: :item_type do |version|
      if version.item_type == "Book"
        status_tag "Książka"
      elsif version.item_type == "Favourite"
        status_tag "Do przeczytania"
      elsif version.item_type == "FinishedBook"
        status_tag "Przeczytane"
      else
        status_tag "Użytkownik"
      end
    end
    column "Obiekt zmiany", sortable: :item_id do |version|
      if version.item_type == "Book"
        link_to "#{version.item_id}", admin_book_path(Book.find(version.item_id.to_i))
      elsif version.item_type == "User"
        link_to "#{version.item_id}", admin_user_path(User.find(version.item_id.to_i))
      else
        status_tag "#{version.item_id}"
      end
    end
    column "Data", sortable: :created_at do |version|
      version.created_at.strftime("%Y-%m-%d, %H:%M")
    end
    column "Kto zmienił?",sortable: :whodunnit do |version|
      if version.whodunnit.nil?
        status_tag("system", :ok)
      else
        status_tag(User.find(version.whodunnit.to_i).email, :ok)
      end
    end
    column "Zmiana", :changeset do |version|
        if version.changeset.empty?
          div "rekord usunięto"
        else
          version.changeset.each do |key, value|
            if value[0].nil?
              div "podano #{key}: #{value[1]}"
            else
              div "zmieniono #{key}: z #{value[0]} na #{value[1]}"
            end
          end
        end
    end
  end

  show do |version|
    attributes_table do
      row :id
      row "Kto zmienił?" do |version|
        if version.whodunnit.nil?
          status_tag "system"
        else
          user = User.find(version.whodunnit.to_i)
          if user && user.admin?
            status_tag("#{user.email} - admin", :ok)
          elsif user && !user.admin?
            status_tag("#{user.email}", :ok)
          else
            status_tag "unknown"
          end
        end
      end
      row "Obiekt" do |version|
        if version.item_type == "Book"
          link_to "#{Book.find(version.item_id.to_i).title}", admin_book_path(Book.find(version.item_id.to_i))
        elsif version.item_type == "User"
          link_to "#{User.find(version.item_id.to_i).email}", admin_user_path(User.find(version.item_id.to_i))
        else
          status_tag "Lista użytkownika"
        end
      end
      row "Data zmiany"do |version|
        version.created_at.strftime("%Y-%m-%d, %H:%M")
      end
      row "Typ zmiany" do |version|
        if version.changeset.empty?
          div "rekord usunięto"
        else
          version.changeset.each do |key, value|
            if value[0].nil?
              div "podano #{key}: #{value[1]}"
            else
              div "zmieniono #{key}: z #{value[0]} na #{value[1]}"
            end
          end
        end
      end
    end
  end
end
