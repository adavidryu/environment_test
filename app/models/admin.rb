class Admin < ApplicationRecord
  devise :omniauthable, omniauth_providers: [ :google_oauth2 ]

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    normalized_email = email.to_s.strip.downcase
    return if normalized_email.blank?

    admin = find_or_initialize_by(email: normalized_email)
    admin.assign_attributes(uid: uid, full_name: full_name, avatar_url: avatar_url)
    admin.save!
    admin
  end
end
