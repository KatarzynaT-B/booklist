class FinishedBook < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  self.per_page = 20
end
