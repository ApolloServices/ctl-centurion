class Project < ApplicationRecord
  acts_as_paranoid
  has_many :field_notes, dependent: :destroy
  has_many :given_data, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :correspondences, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :calc_registers, dependent: :destroy
  has_many :tasks, dependent: :destroy
  belongs_to :instrument, optional: true
  belongs_to :survey_controller, optional: true
  belongs_to :company, optional: true
  belongs_to :client, optional: true

  validates :project_number, uniqueness: true
  validates :project_number, presence: true

  # has_many :project_timings, dependent: :destroy
  # has_many :timings, through: :project_timings
  has_many :timings, dependent: :destroy

  has_many :to_fields, dependent: :destroy

  scope :active, -> { where(status: true) }
end
