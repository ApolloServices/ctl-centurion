class SurveyController < ApplicationRecord
  acts_as_paranoid

  has_many :projects, dependent: :destroy
  belongs_to :company, optional: true

  validates :name, uniqueness: true
  validates :name, presence: true

  validates :two_digit_id, uniqueness: true
  validates :two_digit_id, presence: true
end
