PaperTrail::Version.class_eval do
  scope :books, -> { where(item_type: 'Book') }
  scope :users, -> { where(item_type: 'User') }
  scope :user_booklists, -> { where(item_type: 'Favourite') || where(item_type: 'FinishedBook') }
end
