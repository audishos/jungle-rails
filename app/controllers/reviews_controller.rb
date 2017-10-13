class ReviewsController < ApplicationController

  before_action :authorize

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to [@product], notice: 'Thanks for submitting a review!'
    else
      redirect_to [@product], notice: 'Error!'
    end
  end

  private

  def review_params
    params.require(:review).permit(:description, :rating)
  end
end
