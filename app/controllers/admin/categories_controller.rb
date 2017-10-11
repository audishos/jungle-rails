class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  # def new
  #   @product = Product.new
  # end

  # def create
  #   @product = Product.new(product_params)

  #   if @product.save
  #     redirect_to [:admin, :products], notice: 'Product created!'
  #   else
  #     render :new
  #   end
  # end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
