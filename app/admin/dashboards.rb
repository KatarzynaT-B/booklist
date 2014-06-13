ActiveAdmin.register_page "Dashboard" do

  content do
    panel "10 ostatnich zmian" do
      ul { li link_to "Pełna historia zmian", admin_paper_trail_versions_path }
      render partial: 'admin/shared/modifications_index',
        locals: { versions: PaperTrail::Version.
          order("created_at DESC").
          where("item_type = ? or item_type = ?", "Book", "User").limit(10) }
    end
  end
end
