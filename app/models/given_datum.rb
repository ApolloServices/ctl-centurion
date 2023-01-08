class GivenDatum < ApplicationRecord
  acts_as_paranoid
  belongs_to :project
  TYPE_IN_COMMING = 'Incomming'
  TYPE_OUT_GOING = 'Outgoing'
    IN_OUT_TYPES = [
      TYPE_IN_COMMING,
      TYPE_OUT_GOING
  ]
  has_many_attached :files
  validates :date, presence: true
  validates :to, presence: true
  validates :from, presence: true

  after_create :create_file_number

  private

  # generates a random, unique file number.
  def create_file_number
    self.update_attribute(:file_id, 'D'+(self.id+10000).to_s)
  end
end
