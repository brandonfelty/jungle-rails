class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_NAME'], password: ENV['ADMIN_PASSWORD']
  def show
    @product_count = Product.count(:all)
    @category_count = Category.count(:all)
  end
end
