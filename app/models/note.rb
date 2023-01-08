class Note < ApplicationRecord
  belongs_to :project

  validates :index, presence: true
  validates :index, uniqueness: true
end
