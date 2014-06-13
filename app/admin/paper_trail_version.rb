ActiveAdmin.register PaperTrail::Version do
  actions :all, except: [:new, :edit, :destroy]

  controller do |version|
    def show
      @version = PaperTrail::Version.find(params[:id])
      render 'show', layout: 'active_admin'
    end
  end

  scope :all, default: true
  scope :books
  scope :users
  scope :user_booklists

  filter :whodunnit, label: 'Zmiany użytkownika'
  filter :created_at, label: 'Zmiany z dnia'

  index do
    render partial: 'admin/shared/modifications_index',
      locals: { versions: PaperTrail::Version.order("created_at DESC") }
  end

end
