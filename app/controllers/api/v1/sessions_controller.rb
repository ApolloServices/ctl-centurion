module Api
  module V1
    class SessionsController < Devise::SessionsController
      acts_as_token_authentication_handler_for User, fallback_to_devise: false

      respond_to :json
      skip_before_action :verify_signed_out_user, only: :destroy

      def create

        user_strong_params = user_params

        @user = User.find_by email: user_strong_params[:email]

        if @user.present? && @user.valid_password?(user_strong_params[:password])

          if @user.authentication_token.nil?
            @user.reset_authentication_token!
          end
          user = {id: @user.id, email: @user.email, first_name: @user.first_name, last_name: @user.last_name, authentication_token: @user.authentication_token}
          # Touch the user, so as to update last updated at:
          @user.touch
          render json: {
              message: 'You have successfully logged In.',
              success: true,
              status: 200,
              user: user
          }
        else
          invalid_login_attempt
        end
      end


      def destroy
        user = current_user
        if user
          session.delete('warden.user.user.key')
          user.reset_authentication_token!
          render json: {message: 'Session deleted.', success: true, status: 200}
        else
          render json: {message: 'Invalid token.', success: false, status: 401}
        end
      end

      ###############################

      private

      ###############################


      def current_user
        authenticate_with_http_token do |token, options|
          User.find_by(authentication_token: token)
        end
      end

      def user_params
        params.permit(:email, :password)
      end

      def invalid_login_attempt
        warden.custom_failure!
        render json: {success: false, message: 'Invalid Email or Password.'}, status: 401
      end

    end
  end
end
