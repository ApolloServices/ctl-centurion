class Stylesheet < ApplicationRecord
  acts_as_paranoid
  # belongs_to :survey_type, optional: true

  has_one_attached :file
  has_one_attached :slx_template
  # has_many :survey_type_default_stylesheets
  # has_many :survey_type_optional_stylesheets
  #
  # has_many :defaults, through: :survey_type_default_stylesheets, source: :survey_type
  # has_many :optionals, through: :survey_type_optional_stylesheets, source: :survey_type
  has_many :survey_type_default_stylesheets, dependent: :destroy
  has_many :survey_type_optional_stylesheets, dependent: :destroy

  belongs_to :company
  belongs_to :user

  STYLESHEET_TYPE_DEFAULT = 'Default'
  STYLESHEET_TYPE_OPTIONAL = 'Optional'
  STYLESHEET_TYPES = [
      STYLESHEET_TYPE_DEFAULT,
      STYLESHEET_TYPE_OPTIONAL
  ]
  validates :unique_id, presence: true

  scope :default_stylesheets, -> { where(stylesheet_type: STYLESHEET_TYPE_DEFAULT) }
  scope :optional_stylesheets, -> { where(stylesheet_type: STYLESHEET_TYPE_OPTIONAL) }
end
