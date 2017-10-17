require 'rails_helper'

RSpec.feature 'Visitor adds a product to their cart', type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'the my cart icon is updated to reflect the number of items in the cart' do

    visit root_path
    click_on('Add', match: :first)

    save_screenshot

    expect(page).to have_link('My Cart (1)')

  end

end