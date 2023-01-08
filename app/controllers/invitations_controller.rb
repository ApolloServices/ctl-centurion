class InvitationsController < ApplicationController

  def new
    @invitation = Invitation.new
  end

  def create
    company = current_user.company
    @invitation = company.invitations.new(invitation_params)
    if @invitation.save
      flash[:notice] = 'Invitation has been sent successfully'
      redirect_to projects_path
    else
      flash[:notice] = @invitation.errors.full_messages.to_sentence
      redirect_to new_invitation_path
    end
  end

  private
  def invitation_params
    params.require(:invitation).permit(:email, :company_id)
  end
end
