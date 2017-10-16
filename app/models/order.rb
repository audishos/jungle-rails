class Order < ActiveRecord::Base

  after_create :reduce_item_quantity

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  private

  def reduce_item_quantity
    line_items.each do |item|
      product = item.product
      product.quantity -= item.quantity
      product.save!
    end
  end

end
