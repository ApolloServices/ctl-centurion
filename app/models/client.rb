class Client < ApplicationRecord
  acts_as_paranoid
  belongs_to :company
  has_many :projects, dependent: :destroy
  validates :name, uniqueness: true
  validates :name, presence: true
end
