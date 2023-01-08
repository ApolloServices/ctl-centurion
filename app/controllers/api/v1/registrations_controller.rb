module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      respond_to :json

      def create

        @user = User.new(user_params)
        if @user.save
          user = {id: @user.id, email: @user.email, first_name: @user.first_name, last_name: @user.last_name, authentication_token: @user.authentication_token}
          render json: {message: 'Registration Successful.', success: true, status: 200, user: user}
        else
          render json: {success: false, message: @user.errors.full_messages.uniq.join(', '), status: 400}
        end
      end

      def update
        @user = User.find_by_id(params[:id])
        if @user.update(user_params)
          render json: {message: 'Registration Successful.', success: true, status: 200, user: user}
        else
          render json: {success: false, message: @user.errors.full_messages.uniq.join(', '), status: 400}
        end
      end

      ###############################

      private

      ###############################

      # Helper to format a successful status, message is optional
      def status_success(message = nil)
        result = {
            success: true
        }
        result[:message] = message if message.present?

        result
      end

      def user_params
        params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :profile_image)
      end

    end

  end
end