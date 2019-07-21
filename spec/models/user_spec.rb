require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Test validations" do
    it "validates email" do
      user = User.new(email: "sarasasasa", password: 'testing123')
      expect(user).not_to be_valid
    end
    it "validates password" do
      user = User.new(email: "sarasa@example.com", password: "al")
      expect(user).not_to be_valid
    end
    it "saves properly" do
      user = User.new(email: "sarasa@example.com", password: "alcapone12")
      expect(user).to be_valid
    end
  end
end
