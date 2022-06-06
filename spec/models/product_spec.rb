require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @category = Category.create(:name => "Test Category", :id => 1)
    @product = Product.new(
      :name => "Test Product", 
      :description => "Lorem ipsum",
      :category_id => 1,
      :quantity => 1,
      :image => "fake image path",
      :price => 100)
  end

  describe 'Validations' do
    it "is valid with all fields set" do
      expect(@product).to be_valid
    end

    it "is not valid without price" do
      @product.price_cents = nil
      expect(@product).to_not be_valid
    end

    it "is not valid without a category" do
      @product.category_id = nil
      expect(@product).to_not be_valid
    end

    it "is not valid without a name" do
      @product.name = nil
      expect(@product).to_not be_valid
    end

    it "is not valid without a quantity" do
      @product.quantity = nil
      expect(@product).to_not be_valid
    end
  end
end
