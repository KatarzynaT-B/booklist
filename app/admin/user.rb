ActiveAdmin.register User do

  permit_params :password, :password_confirmation, :email, :admin

  scope :all, default: true

  filter :id, label: 'ID użytkownika'
  filter :email, label: "Email"
  filter :admin, label: "Administrator?"
  filter :created_at, label: "Data dodania"
  filter :updated_at, label: "Ostatnia zmiana"
  filter :last_sign_in_at, label: "Ostatnie logowanie"
  filter :favourites, label: "Do przeczytania"
  filter :finished_books, label: "Przeczytane"

  index do
    column "Adres email", :email
    column "Admin", sortable: :admin do |user|
      user.admin? ? status_tag("tak", :ok) : status_tag("nie")
    end
    column "Ostatnie logowanie", sortable: :last_sign_in_at do |user|
      user.last_sign_in_at.strftime("%Y-%m-%d, %H:%M") if user.last_sign_in_at?
    end
    column "Data dodania", sortable: :created_at do |user|
      user.created_at.strftime("%Y-%m-%d, %H:%M")
    end
    column "Ostatnia zmiana", sortable: :updated_at do |user|
      user.updated_at.strftime("%Y-%m-%d, %H:%M")
    end
    actions
  end

  form do |f|
    f.inputs 'Użytkownik' do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :admin
    end
    f.actions
  end

  show do |user|
    attributes_table do
      row :email
      row :admin do |user|
        user.admin? ? status_tag("tak", :ok) : status_tag("nie")
      end
      row :created_at
      row :updated_at
      row :last_sign_in_at
    end
  end

  sidebar "Stats", only: :show do
    attributes_table_for user do
      row("Książek do przeczytania:") { |u| u.favourites.count }
      row("Książek przeczytanych:") { |u| u.finished_books.count }
    end
  end
end
