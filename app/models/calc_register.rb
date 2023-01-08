class CalcRegister < ApplicationRecord
  acts_as_paranoid

  belongs_to :surveyor, class_name: 'User', foreign_key: 'surveyor_id', optional: true
  belongs_to :project
  STATUS_IN_PROGRESS = 'In Progress'
  STATUS_COMPLETED = 'Completed'
  STATUS_TYPES = [
      STATUS_IN_PROGRESS,
      STATUS_COMPLETED
  ]
end
