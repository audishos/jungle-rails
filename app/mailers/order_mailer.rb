class OrderMailer < ApplicationMailer

  def order_email(order)
    @order = order
    mail(to: @order.email, subject: "Your order (Order ##{@order.id}) has been received!")
  end

end
