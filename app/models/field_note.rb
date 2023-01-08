class FieldNote < ApplicationRecord
  acts_as_paranoid
  # job_file is used for active storage
  # day_job_file is used for physical files saved on webdav server
  # file_attachments are used for base64 encoded files, needs to remove these
  mount_uploader :day_job_file, DayJobFileUploader
  belongs_to :project
  belongs_to :surveyor, class_name: 'User', foreign_key: 'surveyor_id', optional: true
  has_many :file_attachments, as: :attachable

  has_one_attached :job_file # active storage
  has_one_attached :pdf_file
  has_many_attached :supporting_documents

  validates :description, presence: true

  after_create :create_file_number, :update_day_job
  # after_update :update_day_job

  # upload both the day_job_file and hand written pdf
  def upload_file(file, type)
    if type == 'day_job'

      # delete existing file
      day_job_files = FileAttachment.field_note_job_files(self.id)
      if day_job_files.present?
        day_job_files.destroy_all
      end
    else
      # delete existing file
      pdf_files = FileAttachment.field_note_pdf_files(self.id)
      if pdf_files.present?
        pdf_files.destroy_all
      end
    end
    file_attachment = self.file_attachments.new
    action_service = FileUploadingService.new
    action_service.upload_file(file_attachment, file)
  end


  def field_note_job_file(type)
    file = FieldNote.joins(:file_attachments).where(file_attachments: {extension: type, attachable_id: self.id}).last
    file
  end


  def create_summary_link
    generate_link("summary")
  end

  def create_detail_link
    generate_link("detail")
  end

  def create_jxl_link
    generate_link("jxl")
  end

  def create_fld_link
    generate_link("fld")
  end

  def create_csv_link
    generate_link("csv")
  end
  # private

  def generate_link(type)
    link = "link:smb://CC/cs/projects/#{self.project_id} - Oak Tree Boolaroo AUSTRALASIAN/htm/#{type}/#{self.day_job.split('.').first}.htm"
    link
  end

  # generates a unique file number.
  def create_file_number
    self.update_attribute(:file_id, 'F'+(self.id.to_s.rjust(5,'0')).to_s)
  end

  # method to update day_job field with the name of attached day job file
  def update_day_job
    if self.job_file.attached?
      self.day_job = self.job_file.filename
      self.save
      # update date if nil
      take_date_from_file(self)
    end
  end

  def take_date_from_file(field_note)
    if field_note.date.nil? && field_note.day_job.present?
      # take the date string from file name
      # the formate is JJJJ_YYMMDD_PPCCIITT, the following line take the YYMMDD part
      date_string = field_note.day_job.split('_').second
      # take the year and convert it from 2 digits to 4 digits
      # if it's above 60 then prepend it with 19 otherwise prepend with 20. e.g. if 97 make it 1997, if 17 make it 2017
      year_string = date_string[0..1].to_i > 60 ? "19"+date_string[0..1] : "20"+date_string[0..1]
      month_string = date_string[2..3]
      day_string = date_string[4..5]
      # this gives us the date
      date = Date.today.change(day: day_string.to_i, month: month_string.to_i, year: year_string.to_i)
      field_note.date = date
      field_note.save
    end
  end
end
