Devise.setup do |config|
  config.mailer_sender = "please-change-me@example.com"
  require "devise/orm/active_record"

  config.omniauth :google_oauth2,
    ENV.fetch("GOOGLE_OAUTH_CLIENT_ID", "missing-google-client-id"),
    ENV.fetch("GOOGLE_OAUTH_CLIENT_SECRET", "missing-google-client-secret"),
    scope: "email,profile",
    prompt: "select_account"
end
