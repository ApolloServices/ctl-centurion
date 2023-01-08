class User < ApplicationRecord
  acts_as_token_authenticatable
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable, :token_authenticatable

  # :token_authenticatable, :database_authenticatable, :registerable,
  #     :recoverable, :rememberable, :trackable #, :validatable

  has_person_name

  has_many :notifications, foreign_key: :recipient_id
  has_many :services
  has_many :field_notes, foreign_key: 'surveyor_id', dependent: :destroy
  has_many :calc_registers, foreign_key: 'surveyor_id', dependent: :destroy
  has_many :tasks, foreign_key: 'surveyor_id', dependent: :destroy
  has_many :to_fields, foreign_key: 'surveyor_id', dependent: :destroy
  has_many :timings, foreign_key: 'surveyor_id', dependent: :destroy
  # has_many :projects
  # has_many :surveyors
  # has_many :survey_controllers
  # has_many :survey_types
  # has_many :instruments
  belongs_to :company
  # has_many :clients

  validates_associated :company

  # def reset_authentication_token!
  #   update_column(:authentication_token, Devise.friendly_token)
  # end

  def full_name_initials
    if self.initials.blank?
      (first_name, *, last_name) = self.name.split
      [name_initial(first_name), name_initial(last_name)].reject(&:blank?).join("")
    else
      self.initials
    end
  end

  def name_initial(name)
    if name.present?
      "#{name[0]}"
    else
      ""
    end
  end
end
