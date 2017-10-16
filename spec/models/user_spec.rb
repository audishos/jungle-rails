require 'rails_helper'

RSpec.describe User, type: :model do

  context 'Validations:' do

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should have_secure_password }

    it 'should fail when password is less than 8 characters' do
      @user = User.new(
        first_name: 'John',
        last_name: 'Smith',
        email: 'john@example.com',
        password: '1234567',
        password_confirmation: '1234567'
      )
      @user.save
      expect(@user.id).to be_nil
    end

    it 'should pass when password is 8 characters' do
      @user = User.new(
        first_name: 'John',
        last_name: 'Smith',
        email: 'john@example.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      @user.save!
      expect(@user.id).to be_present
    end

  end

  context '.authenticate_with_credentials' do

    before :all do
      @user = User.new(
        first_name: 'John',
        last_name: 'Smith',
        email: 'john@example.com',
        password: 'correctpassword',
        password_confirmation: 'correctpassword'
      )
      @user.save!
    end

    it 'should return the user john@example.com' do
      user = User.authenticate_with_credentials('john@example.com', 'correctpassword')
      expect(user).to eq(@user)
    end

    it 'should return nil' do
      user = User.authenticate_with_credentials('john@example.com', 'wrongpassword')
      expect(user).to be_nil
    end

    it 'should return the user john@example.com' do
      user = User.authenticate_with_credentials('   john@example.com   ', 'correctpassword')
      expect(user).to eq(@user)
    end

    it 'should return the user john@example.com' do
      user = User.authenticate_with_credentials('jOhN@exaMplE.cOM', 'correctpassword')
      expect(user).to eq(@user)
    end

  end

end
