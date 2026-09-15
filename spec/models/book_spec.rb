require "rails_helper"

RSpec.describe Book, type: :model do
  it "has at least five seeded books" do
    expect(Book.count).to be >= 5
  end
end
