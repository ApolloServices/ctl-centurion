class Timing < ApplicationRecord
  require 'csv'
  acts_as_paranoid
  # has_many :project_timings, dependent: :destroy
  # has_many :projects, through: :project_timings
  belongs_to :project
  belongs_to :surveyor, class_name: 'User', foreign_key: 'surveyor_id', optional: true

  after_create :calculate_total

  def calculate_total
    self.total_duration = self.travel_duration.to_f + self.office_duration.to_f + self.field_duration.to_f
    self.save
  end

  def self.to_csv
    attributes = %w{project_name description date travel_duration field_duration office_duration}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |timing|
        csv << attributes.map{ |attr| timing.send(attr) }
      end
    end
  end

  def project_name
    "#{project.project_number}-#{project.name}"
  end
end
