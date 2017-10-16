require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      @category = Category.create!(name: 'Home Theatre')
      # Setup at least two products with different quantities, names, etc
      @product1 = Product.create!(
        name: 'Samsung 56" OLED',
        description: 'Big and beautiful!',
        price_cents: 200000,
        quantity: 10,
        category_id: @category.id
      )
      @product2 = Product.create!(
        name: 'Sony 60" LCD',
        description: 'Bigger but less beautiful!',
        price_cents: 150000,
        quantity: 6,
        category_id: @category.id
      )
      # Setup at least one product that will NOT be in the order
    end
    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do
      @order = Order.new(stripe_charge_id: 'fake_charge_id')
      @order.line_items.new(
        product_id: @product2.id,
        quantity: 2,
        item_price_cents: @product2.price_cents,
        total_price_cents: @product2.price_cents * 2
      )
      @order.total_cents = @order.line_items.first.total_price_cents
      @order.save!
      @product1.reload
      @product2.reload
      expect(@product2.quantity).to eq(4)
    end
    it 'does not deduct quantity from products that are not in the order' do
      @order = Order.new(stripe_charge_id: 'fake_charge_id')
      @order.line_items.new(
        product_id: @product2.id,
        quantity: 2,
        item_price_cents: @product2.price_cents,
        total_price_cents: @product2.price_cents * 2
      )
      @order.total_cents = @order.line_items.first.total_price_cents
      @order.save!
      @product1.reload
      @product2.reload
      expect(@product1.quantity).to eq(10)
    end
  end
end
