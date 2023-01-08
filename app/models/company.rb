class Company < ApplicationRecord

  has_many :users
  has_many :projects
  has_many :instruments
  has_many :surveyors
  has_many :survey_types
  has_many :stylesheets
  has_many :survey_controllers
  has_many :clients
  has_many :invitations
  validates :name, uniqueness: true
  validates :name, presence: true
end
