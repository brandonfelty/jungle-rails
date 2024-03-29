class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_NAME'], password: ENV['ADMIN_PASSWORD']
  
  def index
    @categories = Category.order(id: :desc)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories],
      notice: 'Product created!'
    else 
      render new
    end
  end

  def category_params
    params.require(:category).permit(
      :name
    )
  end
end
