class Task < ApplicationRecord
  acts_as_paranoid
  belongs_to :project
  belongs_to :surveyor, class_name: 'User', foreign_key: 'surveyor_id', optional: true
end
