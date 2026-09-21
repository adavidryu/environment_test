require "rails_helper"

RSpec.describe "Google OAuth authentication", type: :request do
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: "google_oauth2",
      uid: "123456",
      info: {
        email: "admin@example.com",
        name: "Admin User",
        image: "https://example.com/avatar.jpg"
      }
    )
  end

  after do
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  it "signs in a valid Google user and grants access to the books" do
    post admin_google_oauth2_omniauth_authorize_path
    follow_redirect!
    follow_redirect!

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Successfully authenticated from Google account")
    expect(Admin.find_by(email: "admin@example.com")).to be_present
  end

  it "rejects a failed Google authentication attempt" do
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
    original_admin_count = Admin.count

    post admin_google_oauth2_omniauth_authorize_path
    follow_redirect!
    follow_redirect!

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Could not authenticate you from Google")
    expect(Admin.count).to eq(original_admin_count)
  end

  it "signs an authenticated user out and shows the red confirmation" do
    post admin_google_oauth2_omniauth_authorize_path
    follow_redirect!
    follow_redirect!

    delete destroy_admin_session_path
    follow_redirect!

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Signed out successfully")
    expect(response.body).to include("flash--signed-out")
  end
end
