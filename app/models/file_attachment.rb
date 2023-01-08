class FileAttachment < ApplicationRecord
  # belongs_to :field_note, optional: true
  #
  # belongs_to :file_field_note, optional: true, class_name: 'FieldNote', foreign_key: 'day_job_file_id'

  belongs_to :attachable, polymorphic: true
  # scope :day_job_files, -> { where(extension: "job") }

  scope :field_note_job_files, -> (id) { where(extension: "job", attachable_id: id, attachable_type: 'FieldNote') }
  scope :field_note_pdf_files, -> (id) { where(extension: "pdf", attachable_id: id, attachable_type: 'FieldNote') }

  # belongs_to :, optional: true, class_name: 'FieldNote', foreign_key: 'day_job_file_id'

  # after_create :update_day_job


end
