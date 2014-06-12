class FinishedBook < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  has_paper_trail on: [:create, :destroy]
  # self.per_page = 20
end
