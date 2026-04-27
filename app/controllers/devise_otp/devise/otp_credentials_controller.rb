module DeviseOtp
  module Devise
    class OtpCredentialsController < DeviseController
      include ::Devise::Controllers::Rememberable
      helper_method :new_session_path

      prepend_before_action :authenticate_scope!, only: [:get_refresh, :set_refresh]

      #
      # displays the request for a credentials refresh
      #
      def get_refresh
        ensure_resource!
        render :refresh
      end

      #
      # lets the user through is the refresh is valid
      #
      def set_refresh
        ensure_resource!

        if resource.valid_password?(params[resource_name][:refresh_password])
          done_valid_refresh
        else
          failed_refresh
        end
      end

      private

      def done_valid_refresh
        otp_refresh_credentials_for(resource)
        respond_with resource, location: otp_fetch_refresh_return_url
      end

      def failed_refresh
        otp_set_flash_message :alert, :invalid_refresh, now: true
        render :refresh, status: :unprocessable_entity
      end

      def self.controller_path
        "#{::Devise.otp_controller_path}/otp_credentials"
      end
    end
  end
end
