class Correspondence < ApplicationRecord
  acts_as_paranoid
  belongs_to :project
  has_many_attached :files
  after_create :create_file_number


  # generates a unique file number.
  def create_file_number
    self.update_attribute(:file_id, 'R'+(self.id.to_s.rjust(5,'0')).to_s)
  end
end
