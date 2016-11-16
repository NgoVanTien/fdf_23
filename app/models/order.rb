class Order < ApplicationRecord
  attr_accessor :cart

  has_many :items, dependent: :destroy
  belongs_to :user

  after_save :build_items

  private
  def build_items
    cart.items.each do |item|
      items.create product_id: item.product_id, number: item.quantity,
        price: item.product.price
    end
  end
end
