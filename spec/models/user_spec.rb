require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(
      :first_name => "John",
      :last_name => "Doe",
      :email => "test@test.com",
      :password => "123456",
      :password_confirmation => "123456"
    )
  end

  describe 'Validations' do
    it "is valid with all fields set" do
      @user.save
      expect(@user).to be_valid
    end
    it "is not valid with different password confirmation" do
      @user.password_confirmation = "321"
      @user.save
      expect(@user).to_not be_valid
    end
    it "includes password and password confirmation" do
      @user.password = nil
      @user.password_confirmation = nil
      @user.save
      expect(@user).to_not be_valid
    end
    it "should only allow unique emails" do
      @another_user = User.create(
        :first_name => "John",
        :last_name => "Doe",
        :email => "TEST@TEST.com",
        :password => "123",
        :password_confirmation => "123"
      )
      expect(@another_user).to_not be_valid
    end
    it "is not valid without an email" do
      @user.email = nil
      @user.save
      expect(@user).to_not be_valid
    end
    it "is not valid if the password is less than 6 characters" do
      @user.password = "123"
      @user.password_confirmation = "123"
      @user.save
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it "returns user if authenticated" do
      @user.save
      @session = User.authenticate_with_credentials(
          "test@test.com",
          "123456")
      expect(@session).to be_instance_of User 
    end
    it "returns nil if not authenticated" do
      @user.save
      @session = User.authenticate_with_credentials(
          "wrong@test.com",
          "123456")
      expect(@session).to be_nil
    end
    it "returns user even with spaces" do
      @user.save
      @session = User.authenticate_with_credentials(
          "  test@test.com  ",
          "123456")
      expect(@session).to be_instance_of User 
    end
    it "works regardless of case" do
      @user.email = "eXample@domain.COM"
      @user.save!
      puts @user.inspect
      @session = User.authenticate_with_credentials(
        "EXAMPLe@DOMAIN.CoM",
          "123456")
      expect(@session).to be_instance_of User 
    end
  end
end
