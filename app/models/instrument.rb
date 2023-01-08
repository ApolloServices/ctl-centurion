class Instrument < ApplicationRecord
  acts_as_paranoid

  has_many :projects, dependent: :destroy
  belongs_to :company, optional: true

  # has_one :actual_service_history, class_name: 'FileAttachment', foreign_key: 'actual_service_history_id'
  # has_one :base_line_report, class_name: 'FileAttachment', foreign_key: 'base_line_report_id'
  # has_many :file_attachments, as: :attachable

  has_many_attached :actual_service_history_files
  has_many_attached :base_line_history_files

  validates :name, uniqueness: true
  validates :name, presence: true

  validates :two_digit_id, uniqueness: true
  validates :two_digit_id, presence: true


  def upload_file(file)
    file_attachment = self.file_attachments.new
    action_service = FileUploadingService.new
    action_service.upload_file(file_attachment, file)
  end
end
