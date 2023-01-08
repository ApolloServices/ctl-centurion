class Users::RegistrationsController < Devise::RegistrationsController
  def new
    uuid = params[:company_uuid]
    invitation_uuid = params[:invitation_uuid]
    if uuid && invitation_uuid
      invitation = Invitation.find_by_uuid(invitation_uuid)
      company = Company.find_by_uuid(uuid)
      if invitation.present?
        @user = User.new(email: invitation.email)
        if company.present?
          @user.company = company
        else
          flash[:alert] = 'Company not found by provided Id'
          render 'users/registrations/new'
          return
        end
      else
        @user = User.new
        flash[:alert] = 'Invitation is not valid, please follow correct invitation link to connect to a company, or you can sign up to start just by your own.'
        render 'users/registrations/new'
        return
      end
    else
      super
    end
  end

  def create

    invitation_id = params[:invitation_id]
    if invitation_id
      invitation = Invitation.find_by_id(invitation_id)
      @user = User.new(sign_up_params)
      company = Company.find_by_name(params[:company])
      @user.company = company
      if invitation.present? && params[:user][:email] == invitation.email && company == invitation.company

        @user.company = invitation.company
        # remove company from params
        params.delete :company
      else
        flash[:alert] = 'Invitation is not valid'
        render 'users/registrations/new'
        return
      end
    else
      @user = User.new(sign_up_params)

      company = params[:company]
      if company
        companies = Company.where("name ilike ?", company).to_a
        if companies.blank?
          @user.company = create_company_by_name(company)
        else
          flash[:alert] = "A company by name '#{company}', already exists, please choose a different name or you can join the company by invitation"
          render 'users/registrations/new'
          return
        end
      end
    end



    if @user.save
      flash[:notice] = 'Your account has been successfully created'
      sign_in_and_redirect @user.becomes(User)
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      render 'users/registrations/new'
    end
  end

  def update
    @user = current_user
    if @user.update(sign_up_params)
      flash[:notice] = 'Your account has been successfully updated'
      redirect_to projects_path
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      render 'devise/registrations/edit'
    end
  end

  private
  def sign_up_params
    params.require(:user).permit(:name,  :email, :password, :password_confirmation, :address, :abn, :accounts_contact_name, :accounts_contact_number)
  end
  def after_sign_in_path_for(resource)
    projects_path
  end
  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end

  def create_company_by_name(company_name)
    company = Company.new(name: company_name)
    company.save
    company
  end
end