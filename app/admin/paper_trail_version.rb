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

  member_action :revert, method: :post do
    @version = PaperTrail::Version.find(params[:id])
    if @version.reify
      @version.reify.save!
    else
      @version.item.destroy
    end
    redirect_to admin_paper_trail_versions_path
  end

  action_item only: :show do
    button_to("cofnij do momentu przed tą zmianą", revert_admin_paper_trail_version_path(version))
  end

end
