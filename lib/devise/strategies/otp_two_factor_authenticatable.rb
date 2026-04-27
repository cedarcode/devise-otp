# frozen_string_literal: true

module Devise
  module Strategies
    class OtpTwoFactorAuthenticatable < Devise::Strategies::TwoFactor
      def valid?
        super && params[:token].present?
      end

      def verify_two_factor!(resource)
        recovery = recovery_enabled? && params[:recovery] == "true"
        unless resource.valid_otp_token?(params[:token], recovery)
          fail!(I18n.t(:"devise.otp.otp_credentials.token_invalid"))
        end
      end

      private

      def recovery_enabled?
        resource_class.otp_recovery_tokens && (resource_class.otp_recovery_tokens > 0)
      end

      def resource_class
        mapping.to
      end
    end
  end
end

Warden::Strategies.add(:otp_two_factor_authenticatable, Devise::Strategies::OtpTwoFactorAuthenticatable)
