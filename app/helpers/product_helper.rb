module ProductHelper
  def in_stock?(product)
    product.quantity > 0 ? true : false
  end
end
