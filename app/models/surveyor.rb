class Surveyor < ApplicationRecord

  has_many :field_notes, foreign_key: 'surveyor_id', dependent: :destroy
  belongs_to :company, optional: true

  validates :name, uniqueness: true
  validates :name, presence: true

  validates :two_digit_id, uniqueness: true
  validates :two_digit_id, presence: true

  after_create :create_user

  def create_user
    user_email = self.login
    user_password = self.password
    company_id = self.company.id
    user = User.create(email: user_email, password: user_password, company_id: company_id)
  end
end
