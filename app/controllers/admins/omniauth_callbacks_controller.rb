module Admins
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      admin = Admin.from_google(**from_google_params)

      if admin.present?
        sign_out_all_scopes
        flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: "Google")
        sign_in_and_redirect admin, event: :authentication
      else
        flash[:alert] = I18n.t(
          "devise.omniauth_callbacks.failure",
          kind: "Google",
          reason: "The Google account did not provide an email address."
        )
        redirect_to new_admin_session_path
      end
    end

    protected

    def after_omniauth_failure_path_for(_scope)
      new_admin_session_path
    end

    private

    def from_google_params
      {
        uid: auth.uid,
        email: auth.info.email,
        full_name: auth.info.name,
        avatar_url: auth.info.image
      }
    end

    def auth
      request.env.fetch("omniauth.auth")
    end
  end
end
