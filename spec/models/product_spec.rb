require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should save to the database' do
      @category = Category.new(name: 'Home Theatre')
      @category.save!
      @product = Product.new(
        name: 'Samsung 56" OLED',
        description: 'Big and beautiful!',
        price_cents: 200000,
        quantity: 10,
        category_id: @category.id
      )
      @product.save!
      expect(@product.id).to be_present
    end
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price_cents) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:category_id) }
  end
end
