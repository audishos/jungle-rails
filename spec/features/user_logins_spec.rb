require 'rails_helper'

RSpec.feature "Visitor authenticates successfully", type: :feature, js: true do

  before :each do
    @email = Faker::Internet.email
    @password = SecureRandom.base64(15)
    @user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: @email,
      password: @password,
      password_confirmation: @password
    )
  end

  scenario 'they are taken to the root page' do
    visit login_path

    fill_in 'email', with: @email
    fill_in 'password', with: @password
    click_on 'Submit'

    save_screenshot

    expect(page).to have_current_path(root_path)
  end

end
