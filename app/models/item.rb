class Item < ApplicationRecord
  has_many :tasks
  belongs_to :project
  validates :item_name, uniqueness: true
  validates :item_name, presence: true
end
