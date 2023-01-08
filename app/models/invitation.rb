class Invitation < ApplicationRecord
  after_create :send_invitation_email
  belongs_to :company

  def send_invitation_email
    invitation = Invitation.last # because self does not have uuid yet, since Invitation.last = self here, that's why...
    data = {}
    data[:email] = invitation.email
    if ENV['RAILS_ENV'] == 'production'
      host = "https://ctl-centurion.herokuapp.com"
    else
      host = "http://localhost:3000"
    end
    data[:url] = "#{host}/users/sign_up?company_uuid=#{invitation.try(:company).try(:uuid)}&invitation_uuid=#{invitation.uuid}"
    UserMailer.delay.send_invitation(data)
  end
end
