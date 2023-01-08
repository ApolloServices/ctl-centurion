class SurveyType < ApplicationRecord
  acts_as_paranoid
  belongs_to :company, optional: true
  # has_many :stylesheets, dependent: :destroy

  has_many :survey_type_default_stylesheets, dependent: :destroy
  has_many :survey_type_optional_stylesheets, dependent: :destroy

  has_many :default_stylesheets, through: :survey_type_default_stylesheets, source: :stylesheet
  has_many :optional_stylesheets, through: :survey_type_optional_stylesheets, source: :stylesheet

  validates :two_digit_id, uniqueness: true
  validates :two_digit_id, presence: true

  after_create :assign_default_stylesheets

  def assign_default_stylesheets
    self.default_stylesheets = self.try(:company).try(:stylesheets).try(:default_stylesheets)
    self.save
  end
end
