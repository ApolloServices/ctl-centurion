class ToField < ApplicationRecord
  acts_as_paranoid

  TYPE_APPROVAL = 'Approval'
  TYPE_APPROVED = 'Approved'
  TYPE_SUPERSEDED = 'Superseded'
  STATUS_TYPES = [
    TYPE_APPROVAL,
    TYPE_APPROVED,
    TYPE_SUPERSEDED
  ]


  belongs_to :project
  belongs_to :surveyor, class_name: 'User', foreign_key: 'surveyor_id', optional: true
  has_one_attached :file

  after_create :create_record_id

  # generates a unique record id.
  def create_record_id
    self.update_attribute(:record_id, 'T'+(self.id.to_s.rjust(5,'0')).to_s)
  end
end
