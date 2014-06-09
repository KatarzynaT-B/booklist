ActiveAdmin.register_page "Dashboard" do

#   section "Recently updated content" do
#     table_for PaperTrail::Version.order('id desc').limit(20) do # Use PaperTrail::Version if this throws an error
#       column "Item" { |v| v.item }
#       column "Modified at" { |v| v.created_at.to_s :long }
#       column "Admin" { |v| link_to User.find(v.whodunnit).email, [:admin, User.find(v.whodunnit)] }
#     end
#   end


#   # content title: "Historia" do
#   #   columns do
#   #     column do
#   #       panel "Historia zmian" do
#   #         table_for PaperTrails::Version.order('created_at DESC').limit(10) do
#   #           column("Utworzono") { |version| content_tag(version.created_at, format: "%Y-%m-%d, %H:%M") }
#   #           column("Id") { |version| version.item_id }
#   #           column("Akcja") { |version| version.event }
#   #         end
#   #       end
#   #     end
#   #   end
#   end

#   # sidebar "Aktualizacja" do
#   #   link_to "Zaktualizuj bazę książek", "/admin/books/download"
#   # end

#   # collection_action :download do
#   #   books = BooksImporter.new
#   #   books.import
#   #   redirect_to "/admin/books"
#   # end

#   # content :title => proc{ I18n.t("active_admin.dashboard") } do

#   #   columns do

#   #     column do
#   #       panel "Recent Orders" do
#   #         table_for Order.complete.order('id desc').limit(10) do
#   #           column("State")   {|order| status_tag(order.state)                                    }
#   #           column("Customer"){|order| link_to(order.user.email, admin_customer_path(order.user)) }
#   #           column("Total")   {|order| number_to_currency order.total_price                       }
#   #         end
#   #       end
#   #     end

#   #     column do
#   #       panel "Recent Customers" do
#   #         table_for User.order('id desc').limit(10).each do |customer|
#   #           column(:email)    {|customer| link_to(customer.email, admin_customer_path(customer)) }
#   #         end
#   #       end
#   #     end

#   #   end # columns

#   #   columns do

#   #     column do
#   #       panel "ActiveAdmin Demo" do
#   #         div do
#   #           render('/admin/sidebar_links', :model => 'dashboards')
#   #         end

#   #         div do
#   #           br
#   #           text_node %{<iframe src="https://rpm.newrelic.com/public/charts/6VooNO2hKWB" width="500" height="300" scrolling="no" frameborder="no"></iframe>}.html_safe
#   #         end
#   #       end
#   #     end

#   #   end # columns

#     # Define your dashboard sections here. Each block will be
#     # rendered on the dashboard in the context of the view. So just
#     # return the content which you would like to display.

#     # The dashboard is organized in rows and columns, where each row
#     # divides the space for its child columns equally.

#     # To start a new row, open a new 'columns' block, and to start a
#     # new column, open a new 'colum' block. That way, you can exactly
#     # define the position for each content div.

#     # == Simple Dashboard Column
#     # Here is an example of a simple dashboard column
#     #
#     #   column do
#     #     panel "Recent Posts" do
#     #       content_tag :ul do
#     #         Post.recent(5).collect do |post|
#     #           content_tag(:li, link_to(post.title, admin_post_path(post)))
#     #         end.join.html_safe
#     #       end
#     #     end
#     #   end

#     # == Render Partials
#     # The block is rendererd within the context of the view, so you can
#     # easily render a partial rather than build content in ruby.
#     #
#     #   column do
#     #     panel "Recent Posts" do
#     #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
#     #     end
#     #   end

#   # end # content
end
