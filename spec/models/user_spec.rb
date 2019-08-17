require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Test validations" do
    it "validates email" do
      user = User.new(email: "sarasa", password: "alcapone12", first_name: "John", last_name: "Doe")
      expect(user).not_to be_valid
    end
    it "validates password" do
      user = User.new(email: "sarasa@example.com", password: "al", first_name: "John", last_name: "Doe")
      expect(user).not_to be_valid
    end
    it "saves properly" do
      user = User.new(email: "sarasa@example.com", password: "alcapone12", first_name: "John", last_name: "Doe")
      expect(user).to be_valid
    end
  end
end
